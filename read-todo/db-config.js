const AWS = require("aws-sdk");

AWS.config.update({
  region: "us-east-1",
  endpoint: "172.20.0.5:4566"
});
  
module.exports = { AWS };