import { is_teacher } from "./utils.js";
const overlay = document.querySelector('.overlay');

fetch('../template/topbar.html')
    .then(res => res.text())
    .then(html => document.getElementById('top-bar').innerHTML = html);

fetch('../template/footer.html')
    .then(res => res.text())
    .then(html => document.getElementById('footer').innerHTML = html);

if (is_teacher){
    const sideBar=document.getElementById('side-bar');
    sideBar.innerHTML+='<button class="add-module" id="add-module">+ Add Module</button>'
    
    const modules=document.querySelectorAll('.module');
    modules.forEach(x=> {
        x.innerHTML+='<button class="delete-module">X</button>';
    });
    const materials=document.querySelectorAll('.material');
    materials.forEach(x=>{
        x.innerHTML+='<button class="delete-material">X</button>';
    });
    const addMaterial=document.getElementById('add-material');
    addMaterial.innerHTML+='<section class="material"><button class="add-material-button">+ Add Material</button></section>';
}

const sidebarContainer = document.querySelector('.sidebar-container');
const interactButton = document.querySelector('.interact-button');

function toggleSidebar() {
  sidebarContainer.classList.toggle('hidden');
  overlay.classList.toggle('hidden');
}

interactButton.addEventListener('click', toggleSidebar);

const modules= document.querySelectorAll('.module-button');
modules.forEach(button => {
    button.addEventListener('click',()=>{
        modules.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        toggleSidebar();
    })
})

fetch('../template/quiz.html')
    .then(res => res.text())
    .then(html => {
        document.getElementById('quiz').innerHTML = html;
        
        // NOW attach the event listeners after HTML is inserted
        const questionButtons = document.querySelectorAll('.scroll-questions button');
        console.log('Found buttons:', questionButtons.length);
        
        questionButtons.forEach((button, index) => {
            button.addEventListener('click', () => {
                console.log('Button clicked:', index + 1);
                questionButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');
                loadQuestion(index);
            });
        });
    });

function loadQuestion(questionIndex) {
    
}



