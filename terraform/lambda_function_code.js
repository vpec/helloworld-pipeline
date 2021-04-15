exports.handler = (event, context, callback) => {
    console.log("Hello world! It's lambda");
    console.log("TODO: Integrate with K8s cluster to execute:");
    console.log("kubectl set image deploy helloworld-rest-app helloworld-rest-app=vpec1/helloworld-rest-app:latest");
    callback(null, 'It works!');
}