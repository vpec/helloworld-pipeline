exports.handler = (event, context, callback) => {
    console.log("Hello world! It's lambda");
    callback(null, 'It works!');
}