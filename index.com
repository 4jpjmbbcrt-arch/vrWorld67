<!DOCTYPE html>
<html lang="he">
<head>
<meta charset="UTF-8">
<title>VR - מחסן 7</title>

<style>
body {
    margin: 0;
    background: black;
    font-family: monospace;
    color: #00ffcc;
    direction: rtl;
    overflow: hidden;
}

/* מסך VR */
#viewport {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    cursor: grab;
}

/* חדר */
#room {
    width: 2200px;
    height: 1400px;
    background: radial-gradient(#061b1b, black);
    position: relative;
    transform-origin: center;
}

/* מצלמות מרכזיות (גדולות באמצע) */
.cam {
    position: absolute;
    width: 320px;
    height: 200px;
    border: 2px solid #00ffcc;
    border-radius: 10px;
    box-shadow: 0 0 15px #00ffcc;
}

#cam1 { top: 200px; left: 400px; }
#cam2 { top: 200px; left: 800px; }
#cam3 { top: 200px; left: 1200px; }
#cam4 { top: 550px; left: 600px; }
#cam5 { top: 550px; left: 1000px; }

/* פאנל מידע צד */
#panel {
    position: fixed;
    top: 20px;
    right: 20px;
    width: 300px;
    background: rgba(0,0,0,0.8);
    border: 1px solid #00ffcc;
    padding: 12px;
    border-radius: 10px;
}

/* אזהרה */
#warning {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    font-size: 70px;
    display: none;
}

/* כפתור פעולה */
button {
    margin-top: 10px;
    padding: 10px;
    width: 100%;
    border: none;
    border-radius: 8px;
    background: #1f6feb;
    color: white;
    cursor: pointer;
}

button:hover {
    background: #388bfd;
}
</style>

</head>

<body>

<div id="viewport">

<div id="room">

<!-- מצלמות אבטחה -->
<img src="IMAGES/cam1.jpg" alt="Camera 1">
<img src="IMAGES/cam2.jpg" alt="Camera 2">
<img src="IMAGES/cam3.jpg" alt="Camera 3">
<img src="IMAGES/cam4.jpg" alt="Camera 4">
<img src="IMAGES/cam5.jpg" alt="Camera 5">

</div>

</div>

<!-- פאנל מידע -->
<div id="panel">
<h3>📁 מחסן 7</h3>

<p>סטטוס: סגור רשמית לפני 7 שנים</p>
<p>קוד מערכת: <b>M77</b></p>
<p>סיווג: מבנה נטוש עירוני</p>
<p>סיכון: ⚠ פעילות חריגה פעילה</p>

<hr>

<p>זוהה פעילות חריגה לשלוח כוחות לאירוע?</p>

<button onclick="sendUnits()">שלח כוחות לזירה</button>
</div>

<!-- אזהרה -->
<div id="warning">⚠️ תנועה זוהתה במחסן ⚠️</div>

<script>

let offsetX = 0;
let offsetY = 0;
let isDragging = false;
let startX, startY;

const room = document.getElementById("room");

/* VR תנועה */
document.getElementById("viewport").addEventListener("mousedown", (e) => {
    isDragging = true;
    startX = e.clientX;
    startY = e.clientY;
});

document.addEventListener("mouseup", () => {
    isDragging = false;
});

document.addEventListener("mousemove", (e) => {
    if(!isDragging) return;

    offsetX += e.movementX;
    offsetY += e.movementY;

    room.style.transform = `translate(${offsetX}px, ${offsetY}px)`;
});

/* אירוע אחרי 30 שניות */
setTimeout(() => {
    document.getElementById("warning").style.display = "block";

    setTimeout(() => {
        document.getElementById("warning").style.display = "none";
    }, 3000);

}, 30000);

/* שליחת כוחות */
function sendUnits() {
    document.getElementById("panel").innerHTML =
        "🚔 כוחות נשלחו לזירה בהצלחה<br><br>אנא הסתכלו בטלוויזיה!";
}

</script>

</body>
</html>
