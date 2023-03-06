const fs = require('fs');
const express = require('express');
const app = express();
const path = require('path');
const router = express.Router();


__dirname += "/html";

router.get('/',function(req,res) {
	try {
		res.sendFile(path.join(__dirname+'/index.html'));
	} catch (error) {
		console.error("Error finding files");
		process.exit()
	}
});

router.get('/main.js',function(req,res){
	try {
		res.sendFile(path.join(__dirname+'/main.js'));
	} catch (error) {
		console.error("Error finding files");
		process.exit()
	}
});

router.get('/main.css',function(req,res){
	try {
		res.sendFile(path.join(__dirname+'/main.css'));
	} catch (error) {
		console.error("Error finding files");
		process.exit()
	}
});

router.get('/words.txt',function(req,res) {
	try {
		res.sendFile(path.join(__dirname+'/words.txt'));
	} catch (error) {
		console.error("Error finding files");
		process.exit()
	}
});

router.get('/words-fr.txt',function(req,res) {
	try {
		res.sendFile(path.join(__dirname+'/words-fr.txt'));
	} catch (error) {
		console.error("Error finding files");
		process.exit()
	}
});

const files = [__dirname+'/words.txt', __dirname+'/main.js', __dirname+'/index.html', __dirname+'/main.css']

files.forEach((e) => {
	if (!fs.existsSync(e)) {
		console.error("Error finding files")
		process.exit()
	}
});

//add the router
app.use('/', router);
app.listen(process.env.port || 3000);

console.log('Running http://localhost:3000');