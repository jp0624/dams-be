// var express = require('express');
// const router = express.Router();

// // Import User Module Containing Functions Related To User Data
// var localize = require('../models/localize');
// var server = require('../models/server');

// var response;
// var task;

// router.get('/localize/:task_id/:country?/:lang?', function(req, res) {

//     response = res;
//     //console.log('REQUEST: ', req)
//     // params.task
//     // params.country
//     // params.lang
//     let queue = 0;

// 	localize.getTaskData(req.params, (t_err, t_rows) => {
//         if(t_err) { console.log('Error: ', t_err); throw t_err }
//         else {
//             task = t_rows[0]

//             localize.getTaskGroups(task, (tg_err, tg_rows) => {
//                 if(tg_err) { console.log('Error: ', tg_err); throw tg_err }
//                 else {
//                     task.groups = [];
                    
//                     this.queue = this.queue + tg_rows.length

//                     for(let tg_i in tg_rows){
//                         console.log('===============================');
//                         console.log('===========( GROUP )===========');
//                         console.log('GROUP: ', tg_rows[tg_i])
//                         console.log('===============================');
//                         console.log('===============================');

//                         task.groups.push(tg_rows[tg_i]);
//                         this.queue--
                        
//                         localize.getTaskGroupContent(tg_rows[tg_i], (tgc_err, tgc_rows) => {
//                             if(tgc_err) { console.log('Error: ', tgc_err); throw tgc_err }
//                             else {
//                                 console.log('===============================');
//                                 console.log('======( GROUP - CONTENT )======');
//                                 console.log('tgc_rows: ', tgc_rows)
//                                 console.log('===============================');
//                                 console.log('===============================');
//                                 task.groups[tg_i].content = [];

//                                 this.queue = this.queue + tgc_rows.length

//                                 for(let tgc_i in tgc_rows){
                                    

//                                     task.groups[tg_i].content.push(tgc_rows[tgc_i])
                                    
//                                     console.log('tgc_rows[tgc_i]: ', tgc_rows[tgc_i].content_id)
//                                     console.log('tgc_rows[tgc_i]: ', tgc_rows[tgc_i].content_id)
//                                     console.log('tgc_rows[tgc_i]: ', tgc_rows[tgc_i].content_id)
//                                     console.log('tgc_rows[tgc_i]: ', tgc_rows[tgc_i].content_id)

//                                     localize.getContentTranslation(tgc_rows[tgc_i].content_id, (ct_err, ct_rows) => {
//                                         if(ct_err) { console.log('Error: ', ct_err); throw ct_err }
//                                         else {
//                                             console.log('ct_rows: ' , ct_rows)
//                                             console.log('ct_rows: ' , ct_rows)
//                                             console.log('ct_rows: ' , ct_rows)
//                                             if(ct_rows > 0){
//                                                 task.groups[tg_i].content.push(ct_rows[0])
//                                             } else {
//                                                 task.groups[tg_i].content.content_value = 'Empty'
//                                             }
//                                             this.queue--
//                                             if(queue === 0){
//                                                 console.log(task);
//                                                 res.status(200).send(task);
//                                                 //reqComplete(task);
                                                
        
//                                             }
//                                         }
//                                         console.log('=============');
//                                     });
                                    
//                                     console.log('=============');
//                                 }

//                             };
//                         });
//                     }

//                 };
//             });
//         };
//     });

//     // sendResponse( ()=> {
//     // });
//     /*
//     console.log('=============');
//     console.log(task);
//     console.log('=============');
//     res.status(200).send(task);
//     */

// });

// function reqComplete(task) {
//     console.log('complete!');
//     response.json(task);
// };

// //https://codeburst.io/node-js-mysql-and-promises-4c3be599909b

// module.exports = router;