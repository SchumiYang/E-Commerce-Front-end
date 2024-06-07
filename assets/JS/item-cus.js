document.addEventListener('DOMContentLoaded', function() {
    const configItems = document.querySelectorAll('.config-item');
    const priceInput = document.querySelector('.price');
    const priceStep = 100; // 每次增減的價格
    var price = document.querySelector('.price');

    // 更新價格函數
    function updatePrice(change) {
        let currentPrice = parseInt(priceInput.value, 10);
        currentPrice += change;
        priceInput.value = currentPrice;
    }

    configItems.forEach(configItem => {
        const targetClass = configItem.getAttribute('data-target');
        const targetElem = document.querySelector(`.${targetClass}`);
        const inputNumber = configItem.querySelector('input[type="number"]');
        const minusButton = configItem.querySelector('.minus');
        const plusButton = configItem.querySelector('.plus');

        // Mouseover and mouseout event listeners
        configItem.addEventListener('mouseover', function() {
            if (targetElem) {
                targetElem.style.borderColor = '#00ffcc';
            }
            configItem.classList.add('config-item-hover');
            if (inputNumber) {
                inputNumber.style.backgroundColor = '#00ffcc';
            }
        });

        configItem.addEventListener('mouseout', function() {
            if (targetElem) {
                targetElem.style.borderColor = 'transparent';
            }
            configItem.classList.remove('config-item-hover');
            if (inputNumber) {
                inputNumber.style.backgroundColor = ''; // 恢復原來的背景顏色
            }
        });

        // Click event listeners for minus and plus buttons
        minusButton.addEventListener('click', function() {
            let currentValue = parseInt(inputNumber.value, 10);
            if (currentValue > parseInt(inputNumber.min, 10)) {
                inputNumber.value = currentValue - 1;
                price.value = Number(price.value) - 100;
                updatePrice(-priceStep);
            } else {
                alert("At least 1");
            }
        });

        plusButton.addEventListener('click', function() {
            let currentValue = parseInt(inputNumber.value, 10);
            inputNumber.value = currentValue + 1;
            price.value = Number(price.value) + 100;
            updatePrice(priceStep);
        });
    });
});





// document.addEventListener('DOMContentLoaded', function() {
//     const configItems = document.querySelectorAll('.config-item');

//     configItems.forEach(configItem => {
//         const targetClass = configItem.getAttribute('data-target');
//         const targetElem = document.querySelector(`.${targetClass}`);

//         configItem.addEventListener('mouseover', function() {
//             if (targetElem) {
//                 targetElem.style.borderColor = '#00ffcc';
//             }
//             configItem.classList.add('config-item-hover');
//         });

//         configItem.addEventListener('mouseout', function() {
//             if (targetElem) {
//                 targetElem.style.borderColor = 'transparent';
//             }
//             configItem.classList.remove('config-item-hover');
//         });
//     });
// });

// document.addEventListener('DOMContentLoaded', function() {
//     const configItems = document.querySelectorAll('.config-item');

//     configItems.forEach(configItem => {
//         const targetClass = configItem.getAttribute('data-target');
//         const targetElem = document.querySelector(`.${targetClass}`);
//         const inputNumber = configItem.querySelector('input[type="number"]');

//         configItem.addEventListener('mouseover', function() {
//             if (targetElem) {
//                 targetElem.style.borderColor = '#00ffcc';
//             }
//             configItem.classList.add('config-item-hover');
//             if (inputNumber) {
//                 inputNumber.style.backgroundColor = '#00ffcc';
//             }
//         });

//         configItem.addEventListener('mouseout', function() {
//             if (targetElem) {
//                 targetElem.style.borderColor = 'transparent';
//             }
//             configItem.classList.remove('config-item-hover');
//             if (inputNumber) {
//                 inputNumber.style.backgroundColor = ''; // 恢复原来的背景颜色
//             }
//         });
//     });
// });


// document.addEventListener('DOMContentLoaded', function() {
//     const minusButton = document.querySelector('.quantity .minus');
//     const plusButton = document.querySelector('.quantity .plus');
//     const inputField = document.querySelector('.quantity input[type="number"]');

//     minusButton.addEventListener('click', function() {
//         let currentValue = parseInt(inputField.value);
//         if (currentValue > 1) {
//             inputField.value = currentValue - 1;
//         } else {
//             alert("At least 1");
//         }
//     });

//     plusButton.addEventListener('click', function() {
//         let currentValue = parseInt(inputField.value);
//         inputField.value = currentValue + 1;
//     });
// });
