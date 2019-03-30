const http = require('http');

const server = http.createServer((request, response) => {
	response.writeHead(200, {"Content-Type": "text/html"});
	response.write("<img src='https://media.giphy.com/media/Nx0rz3jtxtEre/giphy.gif' style='width: 100%;' />");
	response.end();
});

const port = process.env.PORT || 1337;
server.listen(port);

console.log("Server running at http://localhost:%d", port);
