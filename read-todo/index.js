// TODO: Add code for reading todos

const { AWS } = require('./db-config');

const docClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async function (event, context) {

  process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0 
  
  console.log(event)
  let response;
  let todoId;
  const table = "Todos";

  if (event) {
    let body = event;
    todoId = body.id;
  }

  const params = {
    TableName: table,
    Key: {
      "id": todoId,
    }
  };

  console.log(params)

  try {
    const data = await docClient.get(params).promise();
    response = {
      'statusCode': 200,
      'body': JSON.stringify({
        message: data,
      })
    }
  } catch (err) {
    response = {
      'statusCode': 400,
      'body': JSON.stringify({
        message: err,
      })
    }
  }
  console.log(response)
  return response;
}

