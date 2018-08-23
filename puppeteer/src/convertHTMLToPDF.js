const puppeteer = require('puppeteer');
let convertHTMLToPDF = async (browser, html, params, callback, options = null) => {
  const page = await browser.newPage();
  await page.goto('data:text/html;charset=UTF-8,' + html, {waitUntil: 'networkidle0'});
  await page.pdf({
    format: 'A4',
    printBackground: true,
    margin: {
      top: params.marginTop || '40px',
      bottom: params.marginBottom || '40px',
      right: '20px',
      left: '20px'
    },
    footerTemplate: params.footer || '',
    headerTemplate: params.header || '',
    displayHeaderFooter: params.showHeaderFooter || false,
  }).then(callback, function (error) {
    console.error('Error generating PDF');
    console.error(error);
  });
};

module.exports = convertHTMLToPDF;
