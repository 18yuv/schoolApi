import express from "express"
import {addSchool, listSchools} from "../controllers/schoolController.js";
import { validateAddSchool, validateListSchools } from "../middlewares/schoolValidation.js";

const schoolRouter = express.Router();

schoolRouter.post("/addSchool", validateAddSchool, addSchool);
schoolRouter.get("/listSchools", validateListSchools, listSchools);

export default schoolRouter;