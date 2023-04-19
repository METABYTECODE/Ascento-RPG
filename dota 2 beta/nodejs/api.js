const express = require('express');
const config = require('./config.json');
const mysql = require("mysql2");
const SteamID = require('steamid');
const axios = require('axios');

const app = express();

const serverKeys = config.keys;
const versionServer = config.version;
const difficulties = config.difficulties;
const admin_id = config.admin_steam_id;
const telebot_token = config.telebot_token;

// create the connection to the MySQL database
const pool = mysql.createPool({
    connectionLimit: 20,
    host: "localhost",
    user: config.db_user,
    database: config.db_name,
    password: config.db_pass
}).promise();


async function removeSqlInjectionChars(str) {
  try {
    if (typeof str !== 'string') {
      return str;
    }
    return str.replace(/[\0\x08\x09\x1a\n\r"'\\\%]/g, '');
  } catch (error) {
    console.error(error);
    throw new Error('Failed to remove SQL injection characters.');
  }
}


async function sendTeleMessage(message) {

    const url = `https://api.telegram.org/bot${telebot_token}/sendMessage?chat_id=YOUR_CHAT_ID&text=${message}&disable_notification=true`;
     try {
        const response = await axios.get(url);
        const data = response.data;
        return true;
    } catch (error) {
        // handle the error
        console.error(error);
        return false;
    }
}

async function checkSteamID(steamID) {
    // convert the steamID to the correct format
    const steamIdObject = new SteamID(steamID);
    const steamId64 = steamIdObject.getSteamID64();
    // construct the url to check the steamID
    const url = `https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=YOUR_STEAM_API_KEY&steamids=${steamId64}`;
    // make the request
    try {
        const response = await axios.get(url);
        const data = response.data;
        // check if the steamID exists
        return data.response.players.length > 0;
    } catch (error) {
        // handle the error
        console.error(error);
        throw error;
    }
}

async function getUserSteamName(steamID) {
  // convert the steamID to the correct format
  let steamId64 = steamID;
  // construct the url to check the steamID
  let url = `https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=YOUR_STEAM_API_KEY&steamids=${steamId64}`;
  //console.log(steamID + " | " + url);

  try {
    const response = await axios.get(url);
    const data = response.data;

    if (data.response.players.length > 0) {
      // return the steam name
      return data.response.players[0]["personaname"];
    } else {
      // return a default name
      return "Player";
    }
  } catch (error) {
    // handle the error
    console.error(error);
    throw error;
  }
}

async function checkUserProfile(steamid) {
    try {
        if (steamid) {
            const [rows] = await pool.query("SELECT COUNT(*) AS `hasPlayer` FROM `ascento_rpg_players` WHERE `steamid` = ?", [steamid]);
            const { hasPlayer } = rows[0];
        
            if (hasPlayer > 0) {
                return true;
            } else {
                
                if (steamid) {
                  await pool.query("INSERT INTO `ascento_rpg_players` (`steamid`) VALUES (?)", [steamid]);
                  return true;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    } catch (err) {
        console.log(err);
        return false;
    }
}


app.get('/api/rpg', async (req, res) => {
    
    //console.log(req.originalUrl);
    let ServerTime = Math.floor(Date.now() / 1000);
    
    const { data, action, difficulty, match_id, gametime, version, key } = req.query;

    if(!data || !action || !difficulty || !match_id || !gametime){
        return res.status(400).json({ message: "Bad request: missing required parameters" });
    }

    if (!difficulties.includes(difficulty)) {
        return res.status(400).json({ message: "Bad request: invalid difficulty" });
    }

    if (version !== versionServer) {
        return res.status(400).json({ message: "Bad request: invalid version" });
    }

    let steam_id;
    let hero_name = null;
    let parsedData;
    
    

    try {
        parsedData = await JSON.parse(data);
        if(parsedData.steam_id){
            steam_id = parsedData.steam_id;
        }
        if(parsedData.hero_name){
            hero_name = parsedData.hero_name;
        }
    } catch (err) {
        return res.status(400).json({ message: "Bad request: invalid data format" });
    }
    
          
    let {
            hero_lvl,
            creep_kills,
            boss_kills,
            deaths,
            slot_0,
            slot_1,
            slot_2,
            slot_3,
            slot_4,
            slot_5,
            slot_6,
            slot_7,
            slot_8,
            slot_neutral,
            endless_1,
            endless_2,
            endless_3,
            endless_4,
            endless_5,
            endless_6,
            endless_7,
            endless_8,
            endless_9,
            endless_10,
            endless_11,
            endless_12,
            endless_13,
            endless_14,
            endless_15,
            checkpoint,
          } = parsedData;
    
    //console.log(steam_id);

    if(!admin_id.includes(steam_id)){
        if (!serverKeys.includes(key)) {
            return res.status(401).json({ message: "Unauthorized" });
        }
    }

    let checkim = await checkUserProfile(steam_id);

    if(!checkim){
        return res.status(404).json({ message: "Steam user not found" });
    }

    switch (action) {
        
        
        // ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE ONLINE 
      case "online":
          try {
            const [hasPlayerRows] = await pool.query(
              "SELECT COUNT(*) AS `hasPlayer` FROM `online_players_ascento_rpg` WHERE `steamid` = ?",
              [steam_id]
            );
            const { hasPlayer } = hasPlayerRows[0];
          
            if (hasPlayer == 0) {
              await pool.query(
                "INSERT INTO online_players_ascento_rpg (steamid, difficulty, match_id, date_online) VALUES (?,?,?,?)",
                [steam_id, difficulty, match_id, ServerTime]
              );
            } else {
              await pool.query(
                "UPDATE online_players_ascento_rpg SET `difficulty` = ?, `match_id` = ?, `date_online` = ? WHERE `steamid` = ?",
                [difficulty, match_id, ServerTime, steam_id]
              );
            }
          
            await pool.query(
              "UPDATE ascento_rpg_players SET `gametime` = `gametime` + 30 WHERE `steamid` = ?",
              [steam_id]
            );
          
            const [coinsRows] = await pool.query(
              "SELECT coins AS `coins` FROM ascento_rpg_players WHERE `steamid` = ? LIMIT 1",
              [steam_id]
            );
          
            const playerCoins = coinsRows[0]["coins"];
          
            const [onlinePlayersRows] = await pool.query(
              "SELECT * FROM online_players_ascento_rpg"
            );
          
            const onlinePlayers = onlinePlayersRows.length;
            const difficulties = ["EASY", "NORMAL", "HARD", "UNFAIR", "IMPOSSIBLE", "HELL", "HARDCORE"];
            const onlineCounts = difficulties.reduce((result, difficulty) => {
              result[difficulty.toLowerCase()] = onlinePlayersRows.filter(p => p.difficulty === difficulty).length;
              return result;
            }, {});
          
            const answer = {
              online: onlinePlayers,
              coins: playerCoins,
              ...onlineCounts,
            };
            
            return res.status(200).json(answer);
          
          } catch (err) {
            console.log(err);
            return res.status(500).json({ message: err });
          }
          break;


        //-----------------------------------------------------------------------------------------------
        
        //FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD FIRST LOAD 
        
        case "firstload":
          try {
            const [userData] = await pool.query(
              "SELECT * FROM ascento_rpg_players WHERE `steamid` = ? LIMIT 1",
              [steam_id]
            );
            return res.status(200).json(userData[0]);
          } catch (err) {
            console.log(err);
            return res.status(500).json({ message: err });
          }
          break;

        
        //-----------------------------------------------------------------------------------------------
        
        //TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD TOP LOAD 
        
          case "topload":
              //console.log(req.originalUrl);
          let creep_killsTOP = [];
          let boss_killsTOP = [];
          let reincarnationTOP = [];
          let all_players = 0;
          const steamidLOAD = steam_id;
        
          try {
            // First query
            const [rows] = await pool.query("SELECT COUNT(*) as count FROM ascento_rpg_players WHERE steamid = ? LIMIT 1", [steamidLOAD]);
            if (rows[0].count === 0) {
              // Insert new player if not found
              await pool.query("INSERT INTO ascento_rpg_players (steamid) VALUES (?)", [steamidLOAD]);
            }
        
            // Second query
            const [rows1] = await pool.query("SELECT steam_id_full, creep_kills FROM ascento_rpg_players ORDER BY creep_kills DESC LIMIT 30");
            if (rows1.length > 0) {
              creep_killsTOP = rows1;
            }
        
            // Third query
            const [rows2] = await pool.query("SELECT steam_id_full, boss_kills FROM ascento_rpg_players ORDER BY boss_kills DESC LIMIT 30");
            if (rows2.length > 0) {
              boss_killsTOP = rows2;
            }
        
            // Fourth query
            const [rows3] = await pool.query("SELECT steam_id_full, reincarnation FROM ascento_rpg_players ORDER BY reincarnation DESC LIMIT 30");
            if (rows3.length > 0) {
              reincarnationTOP = rows3;
            }
        
            // Fifth query
            const [rows4] = await pool.query("SELECT COUNT(*) as count FROM ascento_rpg_players");
            all_players = rows4[0].count;
        
            const sendim = {"creep_top":creep_killsTOP, "boss_top":boss_killsTOP, "reinc_top":reincarnationTOP, "all_players":all_players};
            return res.status(200).json(sendim);
          } catch (error) {
            console.error(error);
            return res.status(200).json({message: "An error occurred while processing your request."});
          }
        break;
        
        //-----------------------------------------------------------------------------------------------
        
        //LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD LOAD 
        
          case "load":
            const [rows] = await pool.query("SELECT * FROM ascento_rpg_save WHERE steamid = ? AND hero_name = ? AND difficulty = ? LIMIT 1", [steam_id, hero_name, difficulty]);
            if (rows.length > 0) {
                const playerData = rows[0];
                const data = {
                    steam_id: playerData.steamid,
                    slot0: playerData.slot_0,
                    slot1: playerData.slot_1,
                    slot2: playerData.slot_2,
                    slot3: playerData.slot_3,
                    slot4: playerData.slot_4,
                    slot5: playerData.slot_5,
                    slot6: playerData.slot_6,
                    slot7: playerData.slot_7,
                    slot8: playerData.slot_8,
                    slot_neutral: playerData.slot_neutral,
                    hero_lvl: playerData.hero_lvl,
                    checkpoint: playerData.checkpoint,
                    creep_kills: playerData.creep_kills,
                    boss_kills: playerData.boss_kills,
                    deaths: playerData.deaths,
                };
                return res.status(200).json(data);
            } else {
                return res.status(200).json({ message: "NO DATA IN DATABASE" });
            }
        break;
        
        //-----------------------------------------------------------------------------------------------
        
        //DONATES DONATES DONATES DONATES DONATES DONATES DONATES DONATES DONATES DONATES DONATES DONATES 
        
          case "donates":
              //console.log(req.originalUrl);
             // hero_name
            try {
                let answer = '';
                
                const [rows] = await pool.query(`SELECT dota_name FROM ascento_rpg_inventory WHERE steamid = ?`, [steam_id]);
                if (rows.length > 0) {
                    for (let i = 0; i < rows.length; i++) {
                        answer += rows[i].dota_name + ' ';
                    }
                    return res.status(200).json({ steam_id: steam_id, donates: answer });
                } else {
                    return res.status(200).json({ message: 'NO DATA IN DATABASE' });
                }
            } catch (err) {
                console.log(err);
                return res.status(500).json({ message: 'Internal server error' });
            }
        break;
        
        //-----------------------------------------------------------------------------------------------
        
        //SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE SAVE 
        
        case "save":
          try {
            const [result] = await pool.query(
              "SELECT COUNT(*) as count FROM ascento_rpg_save WHERE steamid = ? AND hero_name = ? AND difficulty = ? LIMIT 1",
              [steam_id, hero_name, difficulty]
            );
            const count = result[0].count;
            
            let slot_0_value = slot_0;
            let slot_1_value = slot_1;
            let slot_2_value = slot_2;
            let slot_3_value = slot_3;
            let slot_4_value = slot_4;
            let slot_5_value = slot_5;
            let slot_6_value = slot_6;
            let slot_7_value = slot_7;
            let slot_8_value = slot_8;
            let slot_neutral_value = slot_neutral;
            
            if (slot_0 === "" || slot_0 === null) {
              slot_0_value = null;
            }
            if (slot_1 === "" || slot_1 === null) {
              slot_1_value = null;
            }
            if (slot_2 === "" || slot_2 === null) {
              slot_2_value = null;
            }
            if (slot_3 === "" || slot_3 === null) {
              slot_3_value = null;
            }
            if (slot_4 === "" || slot_4 === null) {
              slot_4_value = null;
            }
            if (slot_5 === "" || slot_5 === null) {
              slot_5_value = null;
            }
            if (slot_6 === "" || slot_6 === null) {
              slot_6_value = null;
            }
            if (slot_7 === "" || slot_7 === null) {
              slot_7_value = null;
            }
            if (slot_8 === "" || slot_8 === null) {
              slot_8_value = null;
            }
            if (slot_neutral === "" || slot_neutral === null) {
              slot_neutral_value = null;
            }
        
            const sql = count === 0
              ? "INSERT INTO ascento_rpg_save (steamid, difficulty, hero_name, slot_0, slot_1, slot_2, slot_3, slot_4, slot_5, slot_6, slot_7, slot_8, slot_neutral, hero_lvl, checkpoint, creep_kills, boss_kills, deaths, match_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
              : "UPDATE ascento_rpg_save SET slot_0 = ?, slot_1 = ?, slot_2 = ?, slot_3 = ?, slot_4 = ?, slot_5 = ?, slot_6 = ?, slot_7 = ?, slot_8 = ?, slot_neutral = ?, hero_lvl = ?, checkpoint = ?, creep_kills = ?, boss_kills = ?, deaths = ? WHERE steamid = ? AND hero_name = ? AND difficulty = ?";
        
            const values = count === 0
              ? [steam_id, difficulty, hero_name, slot_0_value, slot_1_value, slot_2_value, slot_3_value, slot_4_value, slot_5_value, slot_6_value, slot_7_value, slot_8_value, slot_neutral_value, hero_lvl, checkpoint, creep_kills, boss_kills, deaths, match_id]
              : [slot_0_value, slot_1_value, slot_2_value, slot_3_value, slot_4_value, slot_5_value, slot_6_value, slot_7_value, slot_8_value, slot_neutral_value, hero_lvl, checkpoint, creep_kills, boss_kills, deaths, steam_id, hero_name, difficulty];
        
            await pool.query(sql, values);
        
            return res.status(200).json({ status: "ok" });
          } catch (err) {
            console.error("Database error:", err);
            console.log(err);
            return res.status(200).json({ error: "Database error" });
          }
          break;

        
        //-----------------------------------------------------------------------------------------------
        
        
        //WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN WIN 
        
        case "win":
          let giveREINC = 1;
          let dif_for_db = "easy_win";
          
          if (difficulty == "EASY") {
            dif_for_db = "easy_win";
            giveREINC = 1;
          } else if (difficulty == "NORMAL") {
            dif_for_db = "normal_win";
            giveREINC = 2;
          } else if (difficulty == "HARD") {
            dif_for_db = "hard_win";
            giveREINC = 4;
          } else if (difficulty == "HARDEVENT") {
            dif_for_db = "hard_event_win";
            giveREINC = 6;
            await sendTeleMessage(steam_id + " | ПОБЕДИТЕЛЬ В ИВЕНТЕ!!! На сложности " + difficulty + " | Получено очков реинкарнации: " + giveREINC);
            
          } else if (difficulty == "UNFAIR") {
            dif_for_db = "unfair_win";
            giveREINC = 8;
          } else if (difficulty == "IMPOSSIBLE") {
            dif_for_db = "impossible_win";
            giveREINC = 16;
          } else if (difficulty == "HELL") {
            dif_for_db = "hell_win";
            giveREINC = 32;
          } else if (difficulty == "HARDCORE") {
            dif_for_db = "hardcore_win";
            giveREINC = 64;
          }
        
          
        
          try {
              const [rows] = await pool.query(
                "SELECT COUNT(*) FROM ascento_rpg_inventory WHERE steamid = ? AND dota_name = 'NewYearPet' LIMIT 1",
                [steam_id]
              );
              const count = rows[0]["COUNT(*)"];
            
              if (count > 0) {
                giveREINC *= 2;
              }
            
              if (steam_id === "120578788") {
                giveREINC *= 3;
              }
            
              const [result] = await pool.query(
                "SELECT COUNT(*) FROM ascento_rpg_save WHERE steamid = ? AND hero_name = ? AND difficulty = ?",
                [steam_id, hero_name, difficulty]
              );
              const count2 = result[0]["COUNT(*)"];
            
              if (count2 > 0) {
                await pool.query(
                  "UPDATE ascento_rpg_save SET slot_0 = NULL, slot_1 = NULL, slot_2 = NULL, slot_3 = NULL, slot_4 = NULL, slot_5 = NULL, slot_6 = NULL, slot_7 = NULL, slot_8 = NULL, hero_lvl = '1', checkpoint = '0', creep_kills = '0', boss_kills = '0', deaths = '0', match_id = 'GAME END' WHERE steamid = ? AND hero_name = ? AND difficulty = ?",
                  [steam_id, hero_name, difficulty]
                );
              }
            
              await pool.query(
                "UPDATE ascento_rpg_players SET " +
                  dif_for_db +
                  " = " +
                  dif_for_db +
                  " + 1, reincarnation = reincarnation + ?, creep_kills = creep_kills + ?, boss_kills = boss_kills + ?, deaths = deaths + ? WHERE steamid = ?",
                [giveREINC, creep_kills, boss_kills, deaths, steam_id]
              );
            
              const [result2] = await pool.query(
                "SELECT * FROM ascento_rpg_players WHERE steamid = ? LIMIT 1",
                [steam_id]
              );
            
              if (result2.length > 0) {
                  if (difficulty !== "HARDEVENT") {
                    const query5 =
                      "UPDATE ascento_rpg_players SET endless_1 = ?, endless_2 = ?, endless_3 = ?, endless_4 = ?, endless_5 = ?, endless_6 = ?, endless_7 = ?, endless_8 = ?, endless_9 = ?, endless_10 = ?, endless_11 = ?, endless_12 = ?, endless_13 = ?, endless_14 = ?, endless_15 = ? WHERE steamid = ?";
                    await pool.query(query5, [
                      endless_1,
                      endless_2,
                      endless_3,
                      endless_4,
                      endless_5,
                      endless_6,
                      endless_7,
                      endless_8,
                      endless_9,
                      endless_10,
                      endless_11,
                      endless_12,
                      endless_13,
                      endless_14,
                      endless_15,
                      steam_id,
                    ]);
                  }
              }
              await sendTeleMessage(steam_id + " | Reinc на сложности " + difficulty + " | Получено очков реинкарнации: " + giveREINC);
              
              return res.status(200).json({ status: "ok" });
            } catch (error) {
              console.error("Database error: ", error.message);
              return res.status(200).json("Database error: " + error.message);
            }

        break;


        
        //-----------------------------------------------------------------------------------------------
        
        
        
        default:
            return res.status(401).json({ message: "Bad request 3" });
    }
});

app.get('/api/rpg/discord', async (req, res) => {
    
    //console.log(req.originalUrl);
    let ServerTime = Math.floor(Date.now() / 1000);

    if(!req.query.action){
        return res.status(401).json({ message: "Bad request 1" });
    }
    
    if (req.query.key !== "TestServerKey"){
        if (!serverKeys.includes(req.query.key) || req.query.version !== versionServer) {
            return res.status(401).json({ message: "Unauthorized" });
        }
    }

    let action = req.query.action;
    let match_id = req.query.match_id;

    if(match_id === null || match_id === ""){
        match_id = "0";
    }
    
    switch (action) {
        
        
        // DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE 
        case "discord":
          try {
            const [hasMatchResult] = await pool.query(
              "SELECT COUNT(*) AS `hasMatch` FROM `ascento_discord_chat` WHERE `from` = 'discord' AND `match_id` = ?",
              [match_id]
            );
            const hasMatch = hasMatchResult[0].hasMatch;
        
            if (hasMatch > 0) {
              const [chatResult] = await pool.query(
                "SELECT id, user, message FROM `ascento_discord_chat` WHERE `from` = 'discord' AND `match_id` = ? ORDER BY id ASC LIMIT 1",
                [match_id]
              );
              if (!chatResult.length) {
                return res.status(200).json("NO DATA");
              }
              const { id, user, message } = chatResult[0];
        
              await pool.query("DELETE FROM ascento_discord_chat WHERE `id` = ?", [id]);
        
              return res.status(200).json({ discord: `${user}: ${message}` });
            } else {
              return res.status(200).json("NO DATA");
            }
          } catch (error) {
            console.log(error.message);
            return res.status(500).json(error.message);
          }
          break;

        
        //-----------------------------------------------------------------------------------------------
        
        // TO DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE DISCORD MESSAGE 
        
       case "todiscord":
          const steamid = req.query.steamid;
          let text = req.query.text;
          let username = await getUserSteamName(steamid);
          
          text = await removeSqlInjectionChars(text);
          username = await removeSqlInjectionChars(username);
        
        
          if (!username || !text || !steamid) {
            return res.status(400).json({ message: "Bad request: invalid input" });
          }
        
          try {
            const [matches] = await pool.query(
              "SELECT DISTINCT match_id FROM `online_players_ascento_rpg` WHERE `match_id` NOT LIKE ?",
              [match_id]
            );
        
            for (const match of matches) {
              await pool.query(
                "INSERT INTO `ascento_discord_chat` (`user`,`message`,`from`, `match_id`, `date_add`) VALUES (?,?,'discord',?,?)",
                [username, text, match.match_id, ServerTime]
              );
            }
        
            await pool.query(
              "INSERT INTO `ascento_discord_chat` (`user`,`message`,`from`, `match_id`, `date_add`) VALUES (?,?,'dota','0',?)",
              [username, text, ServerTime]
            );
        
            return res.status(200).json({ message: "OK", username, text, steamid });
          } catch (error) {
            console.log(error.message);
            return res.status(500).json({ message: "Internal server error", error });
          }
          break;

        
        //-----------------------------------------------------------------------------------------------
        
        default:
            return res.status(401).json({ message: "Bad request 3" });
    }
});

app.use((req, res) => {
    res.status(404).json({ message: 'Not found' });
});

app.listen(config.port, config.host, () => {});