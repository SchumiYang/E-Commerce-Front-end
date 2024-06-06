document.addEventListener('DOMContentLoaded', function() {
    const configItems = document.querySelectorAll('.config-item');

    configItems.forEach(configItem => {
        const targetClass = configItem.getAttribute('data-target');
        const targetElem = document.querySelector(`.${targetClass}`);

        configItem.addEventListener('mouseover', function() {
            if (targetElem) {
                targetElem.style.borderColor = '#00ffcc';
            }
            configItem.classList.add('config-item-hover');
        });

        configItem.addEventListener('mouseout', function() {
            if (targetElem) {
                targetElem.style.borderColor = 'transparent';
            }
            configItem.classList.remove('config-item-hover');
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const minusButton = document.querySelector('.quantity .minus');
    const plusButton = document.querySelector('.quantity .plus');
    const inputField = document.querySelector('.quantity input[type="number"]');

    minusButton.addEventListener('click', function() {
        let currentValue = parseInt(inputField.value);
        if (currentValue > 1) {
            inputField.value = currentValue - 1;
        } else {
            alert("At least 1");
        }
    });

    plusButton.addEventListener('click', function() {
        let currentValue = parseInt(inputField.value);
        inputField.value = currentValue + 1;
    });
});
