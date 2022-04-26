const ShortUniqueId = require('short-unique-id');
const { AWS } = require('./db-config');

const docClient = new AWS.DynamoDB.DocumentClient();
const uid = new ShortUniqueId();


exports.handler =  async function (event, context) {
  console.log(event)
  let response;
  let todoId = uid.randomUUID(4); // unique string of length 4
  let todoBody;
  const table = "Todos";

  if (event) {
    // body =  JSON.parse(event);
    todoId = todoId;
    todoBody = event;
  }

  // console.log('todoId', todoId);
  console.log('todoId', todoBody);
  const params = {
    TableName: table,
    Item: {
      "id": todoId,
      "todo": todoBody.todo
    },
    ReturnConsumedCapacity: "TOTAL"
  };
  // console.log(docClient.put(params)
  // )
  console.log(params)

  try {
    await docClient.put(params).promise();
    response = {
      'statusCode': 200,
      'body': JSON.stringify({
        message: 'Todo created',
        id : todoId
      })
    }
    console.log(response)
  } catch (err) {
    console.log(err)
    response = {
      'statusCode': 400,
      'body': JSON.stringify({
        message: 'An error occurred. Todo not created. Try again!',
      })
    }
  }
  console.log(response)
  return response;
};
