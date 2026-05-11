import express from "express"
import {addSchool, listSchools} from "../controllers/schoolController.js";
import { validateAddSchool, validateListSchools } from "../middlewares/schoolValidation.js";

const schoolRouter = express.Router();

schoolRouter.post("/add-school", validateAddSchool, addSchool);
schoolRouter.get("/list-schools", validateListSchools, listSchools);

export default schoolRouter;