let tabBtns = null;
let tabSubBtns = null;
let tabPanels = null;

function showTab(categoryIndex, subCategoryIndex) {
    // Remove active class from all buttons and panels
    tabBtns.forEach(btn => btn.classList.remove('active'));
    tabSubBtns.forEach(btn => btn.classList.remove('active'));
    tabPanels.forEach(panel => panel.classList.remove('active'));

    // Add active class to the clicked button
    tabBtns[categoryIndex].classList.add('active');
    const subBtns = Array.from(tabBtns[categoryIndex].parentNode.querySelectorAll('.tab-subbtn'));

    if (subBtns.length > 0) {
        // If the category has subcategories
        if (subBtns.length > subCategoryIndex) {
            subBtns[subCategoryIndex].classList.add('active');
        }

        let panelIndex = 0;
        for (let i = 0; i < categoryIndex; i++) {
            panelIndex += tabBtns[i].parentNode.querySelectorAll('.tab-subbtn').length;
        }
        panelIndex += subCategoryIndex;
        tabPanels[panelIndex].classList.add('active');
    } else {
        // If the category doesn't have subcategories, show the corresponding panel
        tabPanels[categoryIndex].classList.add('active');
    }
}

$(document).ready(function () {
    tabBtns = document.querySelectorAll('.tab-btn');
    tabSubBtns = document.querySelectorAll('.tab-subbtn');
    tabPanels = document.querySelectorAll('.tab-panel');

    tabBtns.forEach((btn, index) => {
        btn.addEventListener('click', () => {
            showTab(index, 0); // Show the first subcategory by default
        });
    });
    tabSubBtns.forEach((subbtn) => {
        const categoryBtn = subbtn.parentNode.parentNode;
        const categoryIndex = Array.from(categoryBtn.parentNode.children).indexOf(categoryBtn);
        const subIndex = Array.from(subbtn.parentNode.children).indexOf(subbtn);
        subbtn.addEventListener('click', (event) => {
            console.log(categoryIndex + "/" + subIndex);
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
    button.addEventListener('click', function() {
        var commentSection = this.closest('.tag');
        var commentArea = commentSection.querySelector('.review-form-container');

        if (commentArea.style.display === 'none' || commentArea.style.display === '') {
            commentArea.style.display = 'flex';
        } else {
            commentArea.style.display = 'none';
        }
    });
});