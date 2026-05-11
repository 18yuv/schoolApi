import Joi from "joi"

const schoolSchema = Joi.object({
  name:      Joi.string().min(3).max(255).required(),
  address:   Joi.string().min(5).max(500).required(),
  latitude:  Joi.number().min(-90).max(90).required(),
  longitude: Joi.number().min(-180).max(180).required(),
});

const locationSchema = Joi.object({
  latitude:  Joi.number().min(-90).max(90).required(),
  longitude: Joi.number().min(-180).max(180).required(),
});

export function validateAddSchool(req, res, next) {
  const { error, value } = schoolSchema.validate(req.body, { abortEarly: false });
  if (error) {
    return res.status(400).json({
      success: false,
      message: "Validation failed.",
      errors: error.details.map((d) => d.message),
    });
  }
  req.body = value;
  next();
}

export function validateListSchools(req, res, next) {
  const { error, value } = locationSchema.validate(req.query, { abortEarly: false });
  if (error) {
    return res.status(400).json({
      success: false,
      message: "Validation failed.",
      errors: error.details.map((d) => d.message),
    });
  }
  req.query = value;
  next();
}