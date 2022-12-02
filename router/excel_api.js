var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var excel = require('../models/excel');
var server = require('../models/server');

var course = require('../models/course');
var lesson = require('../models/lesson');
var localize = require('../models/localize');

// Require library
var xl = require('excel4node');
var excelToJson = require('convert-excel-to-json');
var mediaPath = 'media/';
var translationsPath = mediaPath + 'translations/';

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.post('/localizexlsx/', function (req, res) {
  console.log('API XLSX LOCALIZE: ', req.body);

  var data = req.body;
  console.log(data);

  const result = excelToJson({
    sourceFile: `.${data.doc}`,
    outputJSON: true
  });

  console.log(result);
  res.status(200).send(result);

  // task.createContentItem(data, function(err, rows, fields) {
  // 	if(err) {
  // 		console.log('Error: ', err);
  // 	};
  // 	res.status(200).send(rows);
  // })
});

router.get('/convertexcel/:file/:lang_code/:country_code', function (req, res) {
  //router.get('/convertexcel/', function(req, res) {

  const result = excelToJson({
    sourceFile: translationsPath + req.params.file, //MM(21)-TEMPLATE(02-05-2018).xlsx`,
    outputJSON: true
  });

  let translations = result;

  lessons = Object.keys(translations);
  console.log(req.params);
  res.status(200).send(translations);

  let pendingLessons = lessons.length;
  for (let idx in lessons) {
    let pendingtranslations = lessons[idx].length;
    for (let translation of translations[lessons[idx]]) {
      if (
        !translation.A ||
        !translation.C ||
        translation.A === 'Instructions:' ||
        translation.A === 'ID'
      ) {
      } else {
        let data = {
          value: translation.C,
          id: translation.A,
          lang_code: req.params.lang_code,
          country_code: req.params.country_code
        };
        excel.getTranslation(data, function (t_err, t_rows, t_fields) {
          console.log(
            '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ t_rows ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] ',
            t_rows
          );
          if (t_rows.length > 0) {
            excel.updateTranslation(data, function (err, rows, fields) {
              if (err) {
                console.log('Error: ', err);
              }
              console.log(
                '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ UPDATE ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'
              );
              if (0 === --pendingLessons && 0 === --pendingtranslations) {
                console.log('pendingLessons: ', pendingLessons);
                res.status(200).send(rows);
              }
            });
          } else {
            excel.createTranslation(data, function (err, rows, fields) {
              if (err) {
                console.log('Error: ', err);
              }
              console.log(
                '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ CREATE ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'
              );
              if (0 === --pendingLessons && 0 === --pendingtranslations) {
                console.log('pendingLessons: ', pendingLessons);
                res.status(200).send(rows);
              }
            });
          }
        });
      }
    }
  }

  console.log('===============================');
  console.log('===============================');
  console.log('===============================');

  console.log('HERE translations: ', translations.HPAWBT);
});

router.get('/genexcel/:type/:id', function (req, res) {
  var res = res;
  var today = new Date();
  let dd = today.getDate();

  let mm = today.getMonth() + 1;
  const yyyy = today.getFullYear();

  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  today = `${mm}-${dd}-${yyyy}`;

  console.log('PARAMS: ', req.params);
  // Create a new instance of a Workbook class
  var wb = new xl.Workbook();

  // Create a reusable style
  var instruction = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#dce6f1',
      fgColor: '#dce6f1'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var normal = wb.createStyle({
    alignment: {
      wrapText: true
    }
  });
  var information = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var id = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      size: 12
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });

  course.findCourse(req.params, function (c_err, c_rows, c_fields) {
    if (c_err) {
      console.log('Error: ', c_err);
    }
    console.log(c_rows);

    course.findCourseLessons(req.params, function (cl_err, cl_rows, cl_fields) {
      if (cl_err) {
        console.log('Error: ', cl_err);
      }
      console.log(cl_rows);

      let pendingLessons = cl_rows.length;

      if (cl_rows.length > 0) {
        for (let lessonData of cl_rows) {
          ws = wb.addWorksheet(`${lessonData.code}(${lessonData.id})`);

          ws.row(1).setHeight(50);
          ws.row(2).setHeight(50);
          ws.row(3).setHeight(50);
          ws.column(1).setWidth(18);
          ws.column(2).setWidth(60);
          ws.column(3).setWidth(60);

          // row, col
          ws.cell(1, 1, 3, 1, true)
            .string('Instructions:')
            .style(instruction);
          ws.cell(1, 2, 1, 3, true)
            .string(
              'Please translate the text in the column "ENGLISH".  Please provide the translated text in the "TRANSLATION" column.'
            )
            .style(instruction);
          ws.cell(2, 2, 2, 3, true)
            .string(
              'Please do no translate text contained within the curly braces "{ }", or text contained in the mark-up "< >" symbols.'
            )
            .style(instruction);
          ws.cell(3, 2, 3, 3, true)
            .string(
              'Text in cells of this colour are for our information only. Please do not translate.'
            )
            .style(information);

          ws.cell(5, 1)
            .string('ID')
            .style(information);
          ws.cell(5, 2)
            .string('ENGLISH')
            .style(information);
          ws.cell(5, 3)
            .string('TRANSLATION')
            .style(information);

          let nextWbRow = 6;

          console.log('======================');
          console.log(lessonData);
          console.log('======================');
          console.log('======================');
          console.log(lessonData.id);
          console.log('======================');

          lesson.findLessonTasks(lessonData, function (
            lt_err,
            lt_rows,
            lt_fields
          ) {
            if (lt_err) {
              console.log('Error: ', lt_err);
            }

            lessonData.tasks = lt_rows;
            let pendingTasks = lessonData.tasks.length;

            if (lessonData.tasks.length > 0) {
              for (let task_idx in lessonData.tasks) {
                lessonData.tasks[task_idx].task_id =
                  lessonData.tasks[task_idx].id;

                console.log('**************************************');
                console.log('**************************************');
                console.log('**************************************');

                localize.getTaskGroups(
                  lessonData.tasks[task_idx],
                  (tg_err, tg_rows) => {
                    if (tg_err) {
                      console.log('Error: ', tg_err);
                      throw tg_err;
                    } else {
                      // console.log('lg_rows: ', tg_rows)

                      let pendingTaskGroups = tg_rows.length;
                      if (tg_rows.length > 0) {
                        lessonData.tasks[task_idx].groups = tg_rows;

                        for (let group_idx in lessonData.tasks[task_idx]
                          .groups) {
                          // console.log('lt_rows: ', lessonData.tasks[task_idx].groups[group_idx]);
                          // console.log('+++++++++++++++++++++++++++++++++++++++++++++++++++')

                          localize.getTaskGroupContent(
                            lessonData.tasks[task_idx].groups[group_idx],
                            (tgc_err, tgc_rows) => {
                              if (tgc_err) {
                                console.log('Error: ', tgc_err);
                                throw tgc_err;
                              } else {
                                console.log('tgc_rows: ', tgc_rows);
                                let pendingTaskGroupContent = tgc_rows.length;

                                // lessonData.tasks[task_idx].groups[group_idx].content = tgc_rows;
                                //return(lessonData.tasks.push(lt_rows[task_idx]));

                                if (tgc_rows.length > 0) {
                                  lessonData.tasks[task_idx].groups[
                                    group_idx
                                  ].content = tgc_rows;

                                  for (let content_idx in lessonData.tasks[
                                    task_idx
                                  ].groups[group_idx].content) {
                                    //console.log('tgc_rows: ', tgc_rows[group_idx]);
                                    console.log(
                                      '>>>>>>>>>>>>>>> ( 5 ) <<<<<<<<<<<<<<<'
                                    );
                                    console.log(
                                      'pendingTaskGroupContent: ',
                                      pendingTaskGroupContent
                                    );
                                    console.log('pendingTasks: ', pendingTasks);
                                    if (
                                      0 === pendingTaskGroupContent ||
                                      0 === --pendingTaskGroupContent
                                    ) {
                                      console.log(
                                        '>>>>>>>>>>>>>>> ( 4 ) <<<<<<<<<<<<<<<'
                                      );
                                      console.log(
                                        'pendingTaskGroupContent: ',
                                        pendingTaskGroupContent
                                      );
                                      console.log(
                                        'pendingTaskGroups: ',
                                        pendingTaskGroups
                                      );
                                      console.log(
                                        'pendingTasks: ',
                                        pendingTasks
                                      );
                                      if (
                                        0 === pendingTaskGroups ||
                                        0 === --pendingTaskGroups
                                      ) {
                                        console.log(
                                          '>>>>>>>>>>>>>>> ( 3 ) <<<<<<<<<<<<<<<'
                                        );
                                        console.log(
                                          'pendingTaskGroupContent: ',
                                          pendingTaskGroupContent
                                        );
                                        console.log(
                                          'pendingTaskGroups: ',
                                          pendingTaskGroups
                                        );
                                        console.log(
                                          'pendingTasks: ',
                                          pendingTasks
                                        );
                                        if (
                                          0 === pendingTasks ||
                                          0 === --pendingTasks
                                        ) {
                                          console.log(
                                            '>>>>>>>>>>>>>>> ( 2 ) <<<<<<<<<<<<<<<'
                                          );
                                          console.log(
                                            'pendingTaskGroupContent: ',
                                            pendingTaskGroupContent
                                          );
                                          console.log(
                                            'pendingTaskGroups: ',
                                            pendingTaskGroups
                                          );
                                          console.log(
                                            'pendingTasks: ',
                                            pendingTasks
                                          );
                                          console.log(
                                            'pendingLessons: ',
                                            pendingLessons
                                          );
                                          if (
                                            0 === pendingLessons ||
                                            0 === --pendingLessons
                                          ) {
                                            console.log(
                                              '>>>>>>>>>>>>>>> ( 1 ) <<<<<<<<<<<<<<<'
                                            );
                                            console.log(
                                              'pendingTaskGroupContent: ',
                                              pendingTaskGroupContent
                                            );
                                            console.log(
                                              'pendingTaskGroups: ',
                                              pendingTaskGroups
                                            );
                                            console.log(
                                              'pendingTasks: ',
                                              pendingTasks
                                            );
                                            console.log(
                                              'pendingLessons: ',
                                              pendingLessons
                                            );

                                            for (let task of lessonData.tasks) {
                                              //nextWbRow = 6
                                              ws.cell(nextWbRow, 1)
                                                .string('')
                                                .style(information);
                                              ws.cell(nextWbRow, 2)
                                                .string(
                                                  task.name +
                                                  ' id (' +
                                                  task.task_id +
                                                  ')'
                                                )
                                                .style(information);
                                              ws.cell(nextWbRow, 3)
                                                .string('')
                                                .style(information);

                                              ++nextWbRow;
                                              if (task.groups.length > 0) {
                                                for (let group of task.groups) {
                                                  if (group.content) {
                                                    for (let content of group.content) {
                                                      console.log(
                                                        '**************************************'
                                                      );
                                                      console.log(
                                                        '**************************************'
                                                      );
                                                      console.log(content);
                                                      console.log(
                                                        '****************WRITE*****************'
                                                      );
                                                      console.log(
                                                        '**************************************'
                                                      );
                                                      //res.status(200).send(content);
                                                      ws.cell(nextWbRow, 1)
                                                        .string(
                                                          content.content_id.toString()
                                                        )
                                                        .style(id);

                                                      if (
                                                        content.template_value
                                                      ) {
                                                        ws.cell(nextWbRow, 2)
                                                          .string(
                                                            content.template_value
                                                          )
                                                          .style(normal);
                                                      }
                                                      ++nextWbRow;
                                                    }
                                                  } else {
                                                    ++nextWbRow;
                                                  }
                                                }
                                              } else {
                                                ++nextWbRow;
                                              }
                                            }
                                            var filepath =
                                              translationsPath +
                                              c_rows[0].code +
                                              '(' +
                                              c_rows[0].course_id +
                                              ')-TEMPLATE(' +
                                              today +
                                              ').xlsx';
                                            wb.write(filepath);
                                            console.log('EXCEL GENERATED 1');
                                            res.status(200).send(filepath);
                                          }
                                        }
                                      }
                                    }

                                    // if( 0 === --pendingTaskGroupContent
                                    // &&  0 === --pendingTaskGroups
                                    // &&  0 === --pendingTasks
                                    // &&  0 === --pendingLessons ) {
                                    //     wb.write(`./assets/media/translations/${c_rows[0].code}(${c_rows[0].course_id})-TEMPLATE(${today}).xlsx`);
                                    //     //wb.write(`${c_rows[0].code}(${c_rows[0].course_id})-TEMPLATE(${today}).xlsx`);
                                    //     //res.status(200).send('EXCEL GENERATED 1: ' +

                                    //     //ws.cell(5,3).string('TRANSLATION').style(information);

                                    //     for(let task of lessonData.tasks){
                                    //         //nextWbRow = 6
                                    //         ws.cell(nextWbRow,1).string('').style(information);
                                    //         ws.cell(nextWbRow,2).string(task.name + ' task id (' + task.task_id + ')').style(information);
                                    //         ws.cell(nextWbRow,3).string('').style(information);

                                    //         ++nextWbRow;
                                    //         for(let group of task.groups){
                                    //             for(let content of group.content){
                                    //                 console.log('**************************************')
                                    //                 console.log('**************************************')
                                    //                 console.log(content);
                                    //                 console.log('**************************************')
                                    //                 //res.status(200).send(content);
                                    //                 ws.cell(nextWbRow,1).string(content.content_id).style(id);

                                    //                 if(content.template_value){
                                    //                     ws.cell(nextWbRow,2).string(content.template_value).style(normal);
                                    //                 }
                                    //                 ++nextWbRow;
                                    //             }

                                    //         }

                                    //     }

                                    //     // res.status(200).send(lessonData);

                                    // }
                                  }
                                } else {
                                  //console.log('tgc_rows: ', tgc_rows[group_idx]);
                                  console.log(
                                    '>>>>>>>>>>>>>>> ( 5 ) <<<<<<<<<<<<<<<'
                                  );
                                  console.log(
                                    'pendingTaskGroupContent: ',
                                    pendingTaskGroupContent
                                  );
                                  console.log('pendingTasks: ', pendingTasks);
                                  if (
                                    0 === pendingTaskGroupContent ||
                                    0 === --pendingTaskGroupContent
                                  ) {
                                    console.log(
                                      '>>>>>>>>>>>>>>> ( 4 ) <<<<<<<<<<<<<<<'
                                    );
                                    console.log(
                                      'pendingTaskGroupContent: ',
                                      pendingTaskGroupContent
                                    );
                                    console.log(
                                      'pendingTaskGroups: ',
                                      pendingTaskGroups
                                    );
                                    console.log('pendingTasks: ', pendingTasks);
                                    if (
                                      0 === pendingTaskGroups ||
                                      0 === --pendingTaskGroups
                                    ) {
                                      console.log(
                                        '>>>>>>>>>>>>>>> ( 3 ) <<<<<<<<<<<<<<<'
                                      );
                                      console.log(
                                        'pendingTaskGroupContent: ',
                                        pendingTaskGroupContent
                                      );
                                      console.log(
                                        'pendingTaskGroups: ',
                                        pendingTaskGroups
                                      );
                                      console.log(
                                        'pendingTasks: ',
                                        pendingTasks
                                      );
                                      if (
                                        0 === pendingTasks ||
                                        0 === --pendingTasks
                                      ) {
                                        console.log(
                                          '>>>>>>>>>>>>>>> ( 2 ) <<<<<<<<<<<<<<<'
                                        );
                                        console.log(
                                          'pendingTaskGroupContent: ',
                                          pendingTaskGroupContent
                                        );
                                        console.log(
                                          'pendingTaskGroups: ',
                                          pendingTaskGroups
                                        );
                                        console.log(
                                          'pendingTasks: ',
                                          pendingTasks
                                        );
                                        console.log(
                                          'pendingLessons: ',
                                          pendingLessons
                                        );
                                        if (
                                          0 === pendingLessons ||
                                          0 === --pendingLessons
                                        ) {
                                          console.log(
                                            '>>>>>>>>>>>>>>> ( 1 ) <<<<<<<<<<<<<<<'
                                          );
                                          console.log(
                                            'pendingTaskGroupContent: ',
                                            pendingTaskGroupContent
                                          );
                                          console.log(
                                            'pendingTaskGroups: ',
                                            pendingTaskGroups
                                          );
                                          console.log(
                                            'pendingTasks: ',
                                            pendingTasks
                                          );
                                          console.log(
                                            'pendingLessons: ',
                                            pendingLessons
                                          );

                                          for (let task of lessonData.tasks) {
                                            //nextWbRow = 6
                                            ws.cell(nextWbRow, 1)
                                              .string('')
                                              .style(information);
                                            ws.cell(nextWbRow, 2)
                                              .string(
                                                task.name +
                                                ' id (' +
                                                task.task_id +
                                                ')'
                                              )
                                              .style(information);
                                            ws.cell(nextWbRow, 3)
                                              .string('')
                                              .style(information);

                                            ++nextWbRow;
                                            if (task.groups.length > 0) {
                                              for (let group of task.groups) {
                                                if (group.content) {
                                                  for (let content of group.content) {
                                                    console.log(
                                                      '**************************************'
                                                    );
                                                    console.log(
                                                      '**************************************'
                                                    );
                                                    console.log(content);
                                                    console.log(
                                                      '****************WRITE*****************'
                                                    );
                                                    console.log(
                                                      '**************************************'
                                                    );
                                                    //res.status(200).send(content);
                                                    ws.cell(nextWbRow, 1)
                                                      .string(
                                                        content.content_id
                                                      )
                                                      .style(id);

                                                    if (
                                                      content.template_value
                                                    ) {
                                                      ws.cell(nextWbRow, 2)
                                                        .string(
                                                          content.template_value
                                                        )
                                                        .style(normal);
                                                    }
                                                    ++nextWbRow;
                                                  }
                                                } else {
                                                  ++nextWbRow;
                                                }
                                              }
                                            } else {
                                              ++nextWbRow;
                                            }

                                            var filepath =
                                              translationsPath +
                                              c_rows[0].code +
                                              '(' +
                                              c_rows[0].course_id +
                                              ')-TEMPLATE(' +
                                              today +
                                              ').xlsx';
                                            wb.write(filepath);
                                            res
                                              .status(200)
                                              .send('EXCEL GENERATED 2');
                                            console.log(filepath);
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          );
                        }
                      } else {
                        if (
                          0 === --pendingTaskGroups &&
                          0 === --pendingTasks &&
                          0 === --pendingLessons
                        ) {
                          var filepath =
                            translationsPath +
                            c_rows[0].code +
                            '(' +
                            c_rows[0].course_id +
                            ')-TEMPLATE(' +
                            today +
                            ').xlsx';
                          wb.write(filepath);
                          res.status(200).send('EXCEL GENERATED 3');
                          console.log(filepath);
                        }
                      }
                    }
                  }
                );
              }
            } else {
              console.log('cDATA: ', pendingLessons + ' ' + pendingTasks);
              if (0 === --pendingTasks && 0 === --pendingLessons) {
                var filepath =
                  translationsPath +
                  c_rows[0].code +
                  '(' +
                  c_rows[0].course_id +
                  ')-TEMPLATE(' +
                  today +
                  ').xlsx';
                wb.write(filepath);
                res.status(200).send('EXCEL GENERATED 4');
                console.log(filepath);
              }
            }
          });
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('lessonData: ', lessonData);
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          // console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        }
      } else {
        console.log('dDATA: ', pendingLessons);
        if (0 === --pendingLessons) {
          var filepath =
            translationsPath +
            c_rows[0].code +
            '(' +
            c_rows[0].course_id +
            ')-TEMPLATE(' +
            today +
            ').xlsx';
          wb.write(filepath);
          res.status(200).send(filepath);
        }
      }
    });
  });
});

router.get('/genexcel-manual-new/:type/:id', function (req, res) {
  var res = res;
  var today = new Date();
  let dd = today.getDate();

  let mm = today.getMonth() + 1;
  const yyyy = today.getFullYear();
  const time = today.getTime();
  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  today = `${mm}-${dd}-${yyyy}-${time}`;

  console.log('PARAMS: ', req.params);
  // Create a new instance of a Workbook class
  var wb = new xl.Workbook();

  // Create a reusable style
  var instruction = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#dce6f1',
      fgColor: '#dce6f1'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var normal = wb.createStyle({
    alignment: {
      wrapText: true
    }
  });
  var information = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var id = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      size: 12
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });

  excel.courseInformationManual(req.params, function (t_err, t_rows, t_fields) {
    console.log('Get');
    console.log(t_rows);

    // res.status(200).send(t_rows);
    let lesson_id = 0;
    let task_id = 0;
    let data_index = 0;

    for (let index in t_rows[0]) {
      let data = t_rows[0][index];

      console.log(data);

      //Lesson
      if (lesson_id != data.lesson_id) {
        if (lesson_id != 0) {
          // Call to dictionary
          if (t_rows[1] && t_rows[1].length > 0) {
            fillDictionaryTerms(wb, ws, lesson_id, t_rows[1], data_index);
          }
        }

        lesson_id = data.lesson_id;
        data_index = 5;

        ws = wb.addWorksheet(`${data.lesson_code}(${data.lesson_id})`);

        ws.row(1).setHeight(50);
        ws.row(2).setHeight(50);
        ws.row(3).setHeight(50);
        ws.column(1).setWidth(18);
        ws.column(2).setWidth(60);
        ws.column(3).setWidth(60);

        // row, col
        ws.cell(1, 1, 3, 1, true)
          .string('Instructions:')
          .style(instruction);
        ws.cell(1, 2, 1, 3, true)
          .string(
            'Please translate the text in the column "ENGLISH".  Please provide the translated text in the "TRANSLATION" column.'
          )
          .style(instruction);
        ws.cell(2, 2, 2, 3, true)
          .string(
            'Please do no translate text contained within the curly braces "{ }", or text contained in the mark-up "< >" symbols.'
          )
          .style(instruction);
        ws.cell(3, 2, 3, 3, true)
          .string(
            'Text in cells of this colour are for our information only. Please do not translate.'
          )
          .style(information);

        ws.cell(5, 1)
          .string('ID')
          .style(information);
        ws.cell(5, 2)
          .string('ENGLISH')
          .style(information);
        ws.cell(5, 3)
          .string('TRANSLATION')
          .style(information);
        task_id = 0;
      }

      //Task title
      if (data.task_id != task_id) {
        ++data_index;
        //Title
        ws.cell(data_index, 1)
          .string('')
          .style(information);
        ws.cell(data_index, 2)
          .string(data.task_name + ' id (' + data.task_id + ')')
          .style(information);
        ws.cell(data_index, 3)
          .string('')
          .style(information);

        task_id = data.task_id;
      }

      // Content
      ++data_index;
      ws.cell(data_index, 1)
        .string(data.content_id.toString())
        .style(id);
      if (data.template_value) {
        ws.cell(data_index, 2)
          .string(data.template_value)
          .style(normal);
      }

      //Call the dictionary for last lesson
      if (+index === t_rows[0].length - 1) {
        // Call to dictionary
        if (t_rows[1] && t_rows[1].length > 0) {
          fillDictionaryTerms(wb, ws, lesson_id, t_rows[1], data_index);
        }
      }
    }

    var filepath =
      translationsPath +
      t_rows[0][0].course_code +
      '(' +
      t_rows[0][0].course_id +
      ')-TEMPLATE(' +
      today +
      ').xlsx';
    wb.write(filepath);
    console.log({ filename: filepath });
    res.status(200).send({ filename: filepath });
  });
});

router.get('/genexcel-new/:type/:id', function (req, res) {
  var res = res;
  var today = new Date();
  let dd = today.getDate();

  let mm = today.getMonth() + 1;
  const yyyy = today.getFullYear();
  const time = today.getTime();
  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  today = `${mm}-${dd}-${yyyy}-${time}`;

  console.log('PARAMS: ', req.params);
  // Create a new instance of a Workbook class
  var wb = new xl.Workbook();

  // Create a reusable style
  var instruction = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#dce6f1',
      fgColor: '#dce6f1'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var normal = wb.createStyle({
    alignment: {
      wrapText: true
    }
  });
  var information = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var id = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      size: 12
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });

  excel.courseInformation(req.params, function (t_err, t_rows, t_fields) {
    console.log('Get');
    console.log(t_rows);

    // res.status(200).send(t_rows);
    let lesson_id = 0;
    let task_id = 0;
    let data_index = 0;

    for (let index in t_rows[0]) {
      let data = t_rows[0][index];

      console.log(data);

      //Lesson
      if (lesson_id != data.lesson_id) {
        if (lesson_id != 0) {
          // Call to dictionary
          if (t_rows[1] && t_rows[1].length > 0) {
            fillDictionaryTerms(wb, ws, lesson_id, t_rows[1], data_index);
          }
        }

        lesson_id = data.lesson_id;
        data_index = 5;
        
        let sheetName = `(${data.vehicle_code})`;
        if (data.versionCode!=null)
         sheetName += `(${data.versionCode})`;
        ws = wb.addWorksheet(`${data.lesson_code}${sheetName}`);

        ws.row(1).setHeight(50);
        ws.row(2).setHeight(50);
        ws.row(3).setHeight(50);
        ws.column(1).setWidth(18);
        ws.column(2).setWidth(60);
        ws.column(3).setWidth(60);

        // row, col
        ws.cell(1, 1, 3, 1, true)
          .string('Instructions:')
          .style(instruction);
        ws.cell(1, 2, 1, 3, true)
          .string(
            'Please translate the text in the column "ENGLISH".  Please provide the translated text in the "TRANSLATION" column.'
          )
          .style(instruction);
        ws.cell(2, 2, 2, 3, true)
          .string(
            'Please do no translate text contained within the curly braces "{ }", or text contained in the mark-up "< >" symbols.'
          )
          .style(instruction);
        ws.cell(3, 2, 3, 3, true)
          .string(
            'Text in cells of this colour are for our information only. Please do not translate.'
          )
          .style(information);

        ws.cell(5, 1)
          .string('ID')
          .style(information);
        ws.cell(5, 2)
          .string('ENGLISH')
          .style(information);
        ws.cell(5, 3)
          .string('TRANSLATION')
          .style(information);
        task_id = 0;
      }

      //Task title
      if (data.task_id != task_id) {
        ++data_index;
        //Title
        ws.cell(data_index, 1)
          .string('')
          .style(information);
        ws.cell(data_index, 2)
          .string(data.task_name + ' id (' + data.task_id + ')')
          .style(information);
        ws.cell(data_index, 3)
          .string('')
          .style(information);

        task_id = data.task_id;
      }

      // Content
      ++data_index;
      ws.cell(data_index, 1)
        .string(data.content_id.toString())
        .style(id);
      if (data.template_value) {
        ws.cell(data_index, 2)
          .string(data.template_value)
          .style(normal);
      }

      //Call the dictionary for last lesson
      if (+index === t_rows[0].length - 1) {
        // Call to dictionary
        if (t_rows[1] && t_rows[1].length > 0) {
          fillDictionaryTerms(wb, ws, lesson_id, t_rows[1], data_index);
        }
      }
    }

    var filepath =
      translationsPath +
      t_rows[0][0].course_code +
      '(' +
      t_rows[0][0].course_id +
      ')-TEMPLATE(' +
      today +
      ').xlsx';
    wb.write(filepath);
    console.log({ filename: filepath });
    res.status(200).send({ filename: filepath });
  });
});

// router.post('/addlesson', function (req, res) {
//   //mongo api call
//   console.log(req.body);
//   excel.storeLesson(req.body, function (err, result) {
//     if (result) {
//       if (result == 'Updated' || result == 'Inserted') {
//         excel.storeInFile(req.body, function (err, result) {
//           if (err) {
//             res.status(500).send(err);
//           }
//           res.status(200).send(result);
//         });
//       }
//     } else if (err) {
//       res.status(500).send(err);
//     } else {
//       res.status(200).send('No Action');
//     }
//   });
// });

function fillDictionaryTerms(wb, ws, lesson_id, data, index) {
  var normal = wb.createStyle({
    alignment: {
      wrapText: true
    }
  });
  var information = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      bold: true,
      size: 14
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });
  var id = wb.createStyle({
    alignment: {
      vertical: 'center',
      horizontal: 'center'
    },
    font: {
      color: '#000000',
      size: 12
    },
    fill: {
      type: 'pattern',
      patternType: 'solid',
      bgColor: '#d9d9d9',
      fgColor: '#d9d9d9'
    },
    border: {
      top: {
        style: 'thin',
        color: '#000000'
      },
      right: {
        style: 'thin',
        color: '#000000'
      },
      bottom: {
        style: 'thin',
        color: '#000000'
      },
      left: {
        style: 'thin',
        color: '#000000'
      }
    }
  });

  ++index;

  ws.cell(index, 1)
    .string('')
    .style(information);
  ws.cell(index, 2)
    .string('Dictionary terms')
    .style(information);
  ws.cell(index, 3)
    .string('')
    .style(information);

  for (let ind in data) {
    let content = data[ind];
    if (content && content.lesson_id == lesson_id) {
      ++index;
      // Dictionary content
      ws.cell(index, 1)
        .string(content.content_id.toString())
        .style(id);

      if (content.term) {
        ws.cell(index, 2)
          .string(content.term)
          .style(normal);
      }
    }
  }
}

module.exports = router;
