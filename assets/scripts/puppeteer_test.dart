import 'package:puppeteer/puppeteer.dart';

void main() async {
  // Download the Chrome binaries, launch it and connect to the "DevTools"
  var browser = await puppeteer.launch(headless: true);

  const testRedirect = 'https://maps.app.goo.gl/YacqDjkdfEuW9x1m8';

  // Open a new tab
  var myPage = await browser.newPage();

  // Go to a page and wait to be fully loaded
  await myPage.goto(testRedirect,
      wait: Until.networkIdle);
  
  print(myPage.url);

  // Gracefully close the browser's process
  await browser.close();
}