const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');
//const app =express();

const server = http.createServer((req, res) => {
  if (req.url.endsWith('.js')) {
    const jsFilePath = path.join(__dirname, req.url);
    fs.readFile(jsFilePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not Found');
      } else {
        res.writeHead(200, { 'Content-Type': 'application/javascript' });
        res.end(data);
      }
    });
  } else if (req.url.endsWith('.css')) {
    const cssFilePath = path.join(__dirname, 'public', req.url);
    fs.readFile(cssFilePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not Found');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/css' });
        res.end(data);
      }
    });
  } else if (req.url.endsWith('.jpg')) {
    const imagePath = path.join(__dirname, 'public', req.url);
    fs.readFile(imagePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not Found');
      } else {
        res.writeHead(200, { 'Content-Type': 'image/jpeg' }); // Set appropriate MIME type
        res.end(data);
      }
    });
  

  } else if (req.url === '/') {
    fs.readFile('menu.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading menu.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });
  } else if (req.url === '/about.html') {
    fs.readFile('about.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading about.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

  } else if (req.url === '/index.html') {
    fs.readFile('index.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading index.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });
  } else if (req.url === '/menu.html') {
    fs.readFile('menu.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading menu.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

  } else if (req.url === '/section1.html') {
    fs.readFile('section1.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section1.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

  } else if (req.url === '/section2.html') {
    fs.readFile('section2.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section2.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

  } else if (req.url === '/section3.html') {
    fs.readFile('section3.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section3.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });
  } else if (req.url === '/section4.html') {
    fs.readFile('section4.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section4.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });
  } else if (req.url === '/section5.html') {
    fs.readFile('section5.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section5.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });


  } else if (req.url === '/section6.html') {
    fs.readFile('section6.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading section6.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

    } else if (req.url === '/rem6.html') {
    fs.readFile('rem6.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading rem6.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });

        } else if (req.url === '/rem4.html') {
    fs.readFile('rem4.html', (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Error loading rem4.html');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(data);
      }
    });




  } else if (req.url === '/runAudit') {
    const mainScriptPath = path.join(__dirname, 'main.sh');
    const outputPath = path.join(__dirname, 'output2.txt');
    exec(`bash ${mainScriptPath} > ${outputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running audit');
      } else {
        fs.readFile(outputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading output.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });
  } 
     else if (req.url === '/runS1') {
    const section2ScriptPath = path.join(__dirname, 'sectionone.sh');
    const servicesOutputPath = path.join(__dirname, 'setup.txt');
        exec(`bash ${section2ScriptPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error running sectionone.sh: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 1 audit');
      } else {
        exec(`cat ${servicesOutputPath}`, (error, stdout, stderr) => {
          if (error) {
            console.error(`Error: ${error.message}`);
            res.writeHead(500);
            res.end('Error serving setup.txt');
          } else {
            const cleanedOutput = stdout.replace(/\^\[\!p\^\[\?3;4l\^\[4l\^\[>\^\[\?69l/g, '');
	    res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(cleanedOutput);
          }
        });
      }
    });
  } else if (req.url === '/runS2') {
    const section2ScriptPath = path.join(__dirname, 'section2.sh');
    const servicesOutputPath = path.join(__dirname, 'services.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 2 audit');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading services.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading services output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });
  } else if (req.url === '/runS3') {
    const section2ScriptPath = path.join(__dirname, 'section3.sh');
    const servicesOutputPath = path.join(__dirname, 'netconfig.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 3 audit');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading netconfig.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading services output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });
  } else if (req.url === '/runS4') {
    const section2ScriptPath = path.join(__dirname, 'section4.sh');
    const servicesOutputPath = path.join(__dirname, 'log.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 4 audit');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading log.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading services output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });
  } else if (req.url === '/runS5') {
    const section2ScriptPath = path.join(__dirname, 'section5.sh');
    const servicesOutputPath = path.join(__dirname, 'aaa.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 5 audit');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading aaa.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });


  } else if (req.url === '/runS6') {
    const section2ScriptPath = path.join(__dirname, 'section6.sh');
    const servicesOutputPath = path.join(__dirname, 'sysmain.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 6 audit');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading sysmain.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });

    } else if (req.url === '/runR6') {
    const section2ScriptPath = path.join(__dirname, 'rem.sh');
    const servicesOutputPath = path.join(__dirname, 'rem6.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 6 Remediation');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading rem6.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });

   } else if (req.url === '/runR4') {
    const section2ScriptPath = path.join(__dirname, 'rem4.sh');
    const servicesOutputPath = path.join(__dirname, 'rem4.txt');
    exec(`bash ${section2ScriptPath} > ${servicesOutputPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        res.writeHead(500);
        res.end('Error running Section 4 Remediation');
      } else {
        fs.readFile(servicesOutputPath, 'utf8', (err, data) => {
          if (err) {
            console.error(`Error reading rem4.txt: ${err}`);
            res.writeHead(500);
            res.end('Error reading output');
          } else {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end(data);
          }
        });
      }
    });

  } else if (req.url === '/failedSections1') {
    const failedSectionsPath = path.join(__dirname, 's1fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s1fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });
  } else if (req.url === '/failedSections3') {
    const failedSectionsPath = path.join(__dirname, 's3fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s3fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });

  } else if (req.url === '/failedSections2') {
    const failedSectionsPath = path.join(__dirname, 's2fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s2fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });
  } else if (req.url === '/failedSections4') {
    const failedSectionsPath = path.join(__dirname, 's4fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s4fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });

  } else if (req.url === '/failedSections5') {
    const failedSectionsPath = path.join(__dirname, 's5fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s5fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });

  } else if (req.url === '/failedSections6') {
    const failedSectionsPath = path.join(__dirname, 's6fails.txt');
    fs.readFile(failedSectionsPath, 'utf8', (err, data) => {
      if (err) {
        console.error(`Error reading s6fails.txt: ${err}`);
        res.writeHead(500);
        res.end('Error reading failed sections');
      } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(data);
      }
    });

  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

const PORT = 3000;

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

