import { is_teacher } from "./utils.js";
fetch('../template/topbar.html')
    .then(res => res.text())
    .then(html => document.getElementById('top-bar').innerHTML = html);

fetch('../template/footer.html')
    .then(res => res.text())
    .then(html => document.getElementById('footer').innerHTML = html);

if (is_teacher){
    const UserdependInfo=document.getElementById('Userdepend-Information');
    UserdependInfo.querySelector('#title').innerHTML='Teacher Information';
    const infoBody=UserdependInfo.querySelector('#info-body')
    infoBody.innerHTML='<p>Title: <span class="info">Computer Scientist</span></p><p>Specialization: </p>';
    infoBody.innerHTML+='<p> - <span class="info">Large Language Model</span></p>'
    infoBody.innerHTML+='<p> - <span class="info">Computer Vision</span></p>'
    const certificateBox=document.getElementById('more-info');
    certificateBox.querySelector('#title').innerHTML='My Courses';
    const infoBody2=certificateBox.querySelector('.info-body');
    infoBody2.innerHTML='';
    infoBody2.innerHTML+='<p> - Course 1</p>';
    infoBody2.innerHTML+='<p> - Course 2</p>';
    infoBody2.innerHTML+='<p> - Course 3</p>';
}

