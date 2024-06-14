let profileBtns = null;
let profileSubBtns = null;
let profilePanels = null;

function showTab(categoryIndex, subCategoryIndex) {
    // Remove active class from all buttons and panels
    profilePanels.forEach(btn => btn.classList.remove('active'));
    profileSubBtns.forEach(btn => btn.classList.remove('active'));
    profilePanels.forEach(panel => panel.classList.remove('active'));

    // Add active class to the clicked button
    profilePanels[categoryIndex].classList.add('active');
    const subBtns = Array.from(profilePanels[categoryIndex].parentNode.querySelectorAll('.tab-subbtn'));

    if (subBtns.length > 0) {
        // If the category has subcategories
        if (subBtns.length > subCategoryIndex) {
            subBtns[subCategoryIndex].classList.add('active');
        }

        let panelIndex = 0;
        for (let i = 0; i < categoryIndex; i++) {
            panelIndex += profilePanels[i].parentNode.querySelectorAll('.tab-subbtn').length;
        }
        panelIndex += subCategoryIndex;
        profilePanels[panelIndex].classList.add('active');
    } else {
        // If the category doesn't have subcategories, show the corresponding panel
        profilePanels[categoryIndex].classList.add('active');
    }
}

$(document).ready(function () {
    profilePanels = document.querySelectorAll('.tab-btn');
    profileSubBtns = document.querySelectorAll('.tab-subbtn');
    profilePanels = document.querySelectorAll('.tab-panel');

    profilePanels.forEach((btn, index) => {
        btn.addEventListener('click', () => {
            showTab(index, 0); // Show the first subcategory by default
        });
    });
    
    profileSubBtns.forEach((subbtn) => {
        const categoryBtn = subbtn.parentNode.parentNode;
        const categoryIndex = Array.from(categoryBtn.parentNode.children).indexOf(categoryBtn);
        const subIndex = Array.from(subbtn.parentNode.children).indexOf(subbtn);
        subbtn.addEventListener('click', (event) => {
            event.stopPropagation(); // Prevent event bubbling to the main category button
            showTab(categoryIndex, subIndex);
        });
    });
});

function ed() {
    var infor = document.getElementById("info");
    var form = document.getElementById("edit");

    infor.style.display = 'none';
    form.style.display = 'flex';
}

function back() {
    var infor = document.getElementById("info");
    var form = document.getElementById("edit");

    infor.style.display = 'flex';
    form.style.display = 'none';
}

document.querySelectorAll('.comment-btn').forEach(button => {
    button.addEventListener('click', function () {
        var commentSection = this.closest('.tag');
        var commentArea = commentSection.querySelector('.review-form-container');

        if (commentArea.style.display === 'none' || commentArea.style.display === '') {
            commentArea.style.display = 'flex';
        } else {
            commentArea.style.display = 'none';
        }
    });
});