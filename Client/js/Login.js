fetch('../template/footer.html')
    .then(res => res.text())
    .then(html => document.getElementById('footer').innerHTML = html);


const loginButton=document.querySelector('.login-button');
loginButton.addEventListener('click', ()=>{
    window.location.href="Home page.html";
});