import { Router } from "express"
import sessionController from "../controllers/sessionController"
import apiController from "../controllers/apiController"
import fs from "fs"
import path from "path"

const routes = Router()

// SESSION ROUTES
routes.post("/web-api/game-proxy/v2/Resources/GetByResourcesTypeIds", sessionController.resourcetypeids)
routes.post("/web-api/auth/session/v2/verifySession", sessionController.verifySession)

// API ROUTES
routes.post("/api/v1/game_launch", apiController.launchgame)
routes.post("/api/v1/getagent", apiController.getagent)
routes.post("/api/v1/attagent", apiController.attagent)

// DYNAMIC GAME ROUTES
const gamesPath = path.join(__dirname, "../controllers/games")
fs.readdirSync(gamesPath).forEach(file => {
  const gameName = file.replace(".js", "") // Remove file extension
  const gameController = require(`../controllers/games/${file}`)

  routes.post(`/game-api/${gameName}/v2/GameInfo/Get`, gameController.getInfo)
  routes.post(`/game-api/${gameName}/v2/Spin`, gameController.spin)
})

export default routes