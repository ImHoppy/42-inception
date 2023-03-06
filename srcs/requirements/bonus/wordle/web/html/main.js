"use strict";
String.prototype.replaceAt = function (index, replacement) {
	return this.substring(0, index) + replacement + this.substring(index + replacement.length);
}
async function fetchAsync(url) {
	if (url === null)
		return null;
	let response = await fetch(url)
		.catch(function (error) {
			console.error("Cant find dictionary!");
			window.stop()
		})
	let data = null;
	if (response.status == 200)
		data = await response?.text();
	return data;
}

jQuery(document).ready(async function () {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const listWords = (await fetchAsync(`words${urlParams.has('lang') ? '-' + urlParams.get('lang') : ''}.txt`)).split('\n').filter(el => {
		return el != "" && el.length == 5 && /^[a-zA-Z]+$/.test(el);
	});
	const tile = $(".tile");

	var currentRow = 0;
	var currentLetter = 0;
	var maxRow = 6;
	var maxLetter = 5;
	var loop = 1;
	const wordsRows = [...new Array(maxRow)].map(x => new Array(maxLetter).fill(''));

	const findingWord = listWords[Math.floor(Math.random() * listWords.length)];
	// const findingWord = "banjos";
	console.log(findingWord)

	wordsRows.forEach((e, i) => {
		var wordsRow = $(`<div id="wordsRow-${i}"></div>`);
		tile.append(wordsRow);
		e.forEach((_, i_) => {
			var words = $(`<div id="wordsRow-${i}-${i_}" class="words"></div>`);
			wordsRow.append(words);
		});
	});
	const keyboardA = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "ENTER", "Z", "X", "C", "V", "B", "N", "M", "←"];
	const keyboard = $(".keyboard");
	keyboardA.forEach((e, i) => {
		var wordsRow = $(`<button class="key" id="${e}">${e}</button>`);
		keyboard.append(wordsRow);
	});



	function addLetter(letter = "") {
		if (currentLetter >= maxLetter || currentRow >= maxRow || letter == "")
			return;
		const letterdiv = $(`#wordsRow-${currentRow}-${currentLetter}`)[0];
		letterdiv.textContent = letter;
		wordsRows[currentRow][currentLetter] = letter;
		// letterdiv.attr("data", letter);
		currentLetter++;
	}
	function removeLetter() {
		if (currentLetter <= 0)
			return;
		currentLetter--;
		const letterdiv = $(`#wordsRow-${currentRow}-${currentLetter}`)[0];
		letterdiv.textContent = '';
		wordsRows[currentRow][currentLetter] = '';
	}

	function flip(doFunc) {
		var tmpRow = currentRow;
		wordsRows[tmpRow].forEach(((e, i) => {
			setTimeout(function () {
				$(`#wordsRow-${tmpRow}-${i}`).addClass("flip");
				setTimeout(function () {
					doFunc(i, e, tmpRow);
				}, 250);
			}, 500 * i);
		}));
	}

	function addDefinition(text) {
		var link = `https://api.dictionaryapi.dev/api/v2/entries/en/${findingWord}`
		var request = fetchAsync(urlParams.has('lang') ? null : link).then((value) => {
			if (value == null)
				return $(".title")[0].outerHTML = `${text} <h2>${findingWord}</h2>`;
			var definition = JSON.parse(value)[0].meanings[0].definitions[0].definition;
			$(".title")[0].outerHTML = `${text} <h2>${findingWord}: ${definition}</h2>`;

		});
	}

	function checkWord() {
		if (currentLetter == maxLetter - 1)
			return;
		var word = wordsRows[currentRow].join('').toLowerCase();
		if (word == findingWord) { // if word is the correct
			flip((i, e) => {
				$(`#wordsRow-${currentRow}-${i}`).addClass("green");
				$(`.keyboard #${e}`).addClass("green");
			});
			addDefinition("<h1>Win !</h1>")
			loop = 0;
			return;
		}
		else {
			if (listWords.includes(word)) { // if word is in dict but not the correct'

				var copyValid = findingWord.toUpperCase();
				var guess = [];
				var tmpRow = currentRow;
				wordsRows[tmpRow].forEach(((e, i) => {
					guess.push({ letter: e, color: "grey", lock: false })
				}));
				guess.forEach(((e, i) => {
					if (e.letter == copyValid.charAt(i)) {
						e.color = "green";
						copyValid = copyValid.replaceAt(i, ' ');
						e.lock = true;
					}
				}));
				guess.forEach(((e, i) => {
					if (!e.lock && copyValid.includes(e.letter)) {
						e.color = "yellow";
						copyValid = copyValid.replace(e.letter, ' ');
						e.lock = true;
					}
				}));
				flip((i, e) => {
					$(`#wordsRow-${tmpRow}-${i}`).addClass(guess[i].color);
					if (!$(`.keyboard #${e}`).attr("class").match(/(yellow|green)/gm))
						$(`.keyboard #${e}`).addClass(guess[i].color);
				});
				currentLetter = 0;
				currentRow++;
			}
		}
		if (currentRow >= maxRow) {
			addDefinition("<h1>Loose..</h1>")
			loop = 0;
			return;
		}
	}
	$(document).on('keydown', function (event) {
		if (!loop)
			return;
		if (event.key == "Enter")
			checkWord();
		else if (event.key == "Backspace")
			removeLetter();
		else if (event.key.match(/[a-zA-Z]/g) && event.key.length == 1)
			addLetter(event.key.toUpperCase())
	});
	$(":button").click((event) => {
		if (!loop)
			return;
		var letter = event.currentTarget.id;
		if (letter == "ENTER")
			checkWord();
		else if (letter == "←")
			removeLetter();
		else if (letter.match(/[a-zA-Z]/g) && letter.length == 1)
			addLetter(letter.toUpperCase())
	})
});
