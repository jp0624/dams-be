var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var media = require('../models/media');
var server = require('../models/server');
var fs = require('fs');
var multer = require('multer');

var upload_path = './media';

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, upload_path)
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname)
        //cb(null, file.fieldname + '-' + Date.now())
    }
  })
//var upload = multer({ dest: `${upload_path}/` });
//var upload = multer({ dest: './assets/media/' }).single('photo');
var upload = multer({ storage: storage }).single('photo');

// router.post('/upload', upload.single('uploaded_file'), function (req, res, next) {
//     console.log('REQUEST: ', req.file)
//     // req.file is the `avatar` file
//     // req.body will hold the text fields, if there were any
// })

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.post('/upload/:path', function (req, res, next) {
    var path = '';
    console.log('reQ.body: ', req.body);
    console.log('reQ.params: ', req.params);
    
    var newDir = req.params.path
    newDir = newDir + ':';
    newDir = '.' + newDir;
    newDir = newDir.replace(/(-?::s*)/g, ':');
    newDir = newDir.replace(/(-?::s*)/g, ':');
    newDir = newDir.replace(/:/g,'/');
    upload_path = newDir;

    console.log('upload_path: ', upload_path);

    upload(req, res, function (err) {
        if (err) {
            console.log('err: ', err);
            return res.status(422).send("an Error occured")
        }else {
            console.log('req.file: ', req.file)
            path = req.file.path;
            console.log('PATH: ', path)
            return res.send("Upload Completed for "+path); 
        }
 });     
})

router.post('/uploadfile/:path', function (req, res, next) {
    var path = '';
    console.log('reQ.body: ', req.body);
    console.log('reQ.params: ', req.params);
    
    var newDir = req.params.path
    newDir = newDir + ':';
    newDir = '.' + newDir;
    newDir = newDir.replace(/(-?::s*)/g, ':');
    newDir = newDir.replace(/(-?::s*)/g, ':');
    newDir = newDir.replace(/:/g,'/');
    upload_path = newDir;

    console.log('upload_path: ', upload_path);

    upload(req, res, function (err) {
        if (err) {
            console.log('err: ', err);
            return res.status(422).send("an Error occured")
        }else {
            console.log('req.file: ', req.file)
            path = req.file.path;
            console.log('PATH: ', path)
            return res.send({ status : 'Success', filename: path }); 
        }
 });     
})

router.post('/createdir/', function(req, res) {

	console.log('API MAKE DIR REQUEST: ', req.body);
    var data = req.body;
    
    var root = '.'
    var newDir = root + data.curDir + data.newDir;
    newDir = newDir.replace(/(-?::s*)/g, ':');
    newDir = newDir.replace(/:/g,'/');

    if (!fs.existsSync(newDir)){
        fs.mkdirSync(newDir);
        res.send(true);
    }

});
router.get('/getfiledata/:filepath', function(req, res) {

    var root = '.'

    var path = req.params.filepath
    path = path.replace(/(-?::s*)/g, ':');
    path = path.replace(/:/g,'/')

    fs.stat(root + path, (err, file) => {

        if(err) {
            res.send(false);
        }
        else {
            if(file.isFile()){
                file.path = path;
                file.type = 'file';
                file.name = getFileName(path);
                file.xtn = getExtension(path);
                file.dir = getDirectory(path) + '/';
            }
            //file.type
            console.log('FILE INFO: ', file);
            
            res.send(file);
            // file.name = files[idx];
            // file.path = files[idx];
            // file.dir = dir;

            // if(file.isDirectory()){
            //     file.type = 'directory';
            //     file.path = dir + files[idx];
            //     fileList.folders.push(file);

            // }else if(file.isFile()){
            //     file.type = 'file';
            //     file.xtn = getExtension(file.path);
            //     fileList.files.push(file);

            // } else {
            //     return;
            // }
            // if( 0 === --pending ) {
            //     console.log('FILE LIST: ', fileList)
            //     res.send(fileList);
            // }
            //console.log('FILE: ', file);
        }
    });


});
router.get('/getfilelist/:path', function(req, res) {

    var fileList = {
        files: [],
        folders: []
    };

    console.log('REQUEST: ', req.params);
    var root = '.'
    var dir = req.params.path
    dir = dir.replace(/(-?::s*)/g, ':');
    dir = dir.replace(/:/g,'/')

    console.log('REQUEST DIR: ', dir);


    fs.readdir(root + dir, function(err, files) {

        if(err) {
            throw err;
        }
        else {
            
            let pending = files.length;
            if(pending === 0){
                fileList = {
                    files: [],
                    folders: []
                }
            }
            for(let idx in files){
                                
                fs.stat(root + dir + files[idx], (err, file) => {

                    if(err) {
                        throw err;
                    }
                    else {
                        //file.type
                        //console.log('EXTENTION: ',file.ext.toLowerCase());
                        file.name = files[idx];
                        file.dir = dir;

                        if(file.isDirectory()){
                            file.type = 'directory';
                            file.path = dir + files[idx];
                            fileList.folders.push(file);

                        }else if(file.isFile()){
                            file.type = 'file';
                            file.path = dir + files[idx];
                            file.xtn = getExtension(file.path);
                            fileList.files.push(file);

                        } else {
                            return;
                        }
                        if( 0 === --pending ) {
                            console.log('FILE LIST: ', fileList)
                            res.send(fileList);
                        }
                        //console.log('FILE: ', file);
                    }
                });
                //res.send(fileList);
            }
        }

    });

    // params.task
    // params.country
    // params.lang

	// media.getFileList(req.params, (err, rows) => {
    //     if(t_err) { console.log('Error: ', t_err); throw t_err }
    //     else {
            
    //         console.log('=============');
    //         console.log(rows);
    //         console.log('=============');

    //     }
    // });
    
    /*
    console.log('=============');
    console.log(this.task);
    console.log('=============');
    res.status(200).send(this.task);
    */

});
function getDirectory(path) {
    
    var i = path.lastIndexOf('/');
    return path.substring(0, i);
    //console.log('last /: ', i)
}

function getExtension(path) {
    var i = path.lastIndexOf('.');
    return (i < 0) ? '' : path.substr(i).replace('.', '');
}
function getFileName(path) {
    var i = path.lastIndexOf('/');
    return (i < 0) ? '' : path.substr(i).replace('/', '');
}
module.exports = router;