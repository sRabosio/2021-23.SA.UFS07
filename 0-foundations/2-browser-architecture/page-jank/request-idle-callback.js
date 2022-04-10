// @ts-check
"use strict";

/**
 * @file ITSAR utility class
 * @version 0.0.1
 * @author Alessandro Aglietti <a.aglietti@itsrizzoli.it>
 */

/**
 * ITSAR utility class constructor
 * @constructor
 */
var ITSAR = function () {

    /**
     * Append one or more {@link LogElement} to an {@link https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement HTMLElement}#log wrapper
     * @param {number} n - amount of {@link LogElement} to append
     * @throws {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypeError TypeError} if the browser didn't support {@link https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback requestIdleCallback}
     * @see {@link ITSAR~appendToUsingIdleCallback}
     * @returns {void}
     */
    this.log = function (n) {
        var logContainer = document.getElementById("log");
        var logElementsEnvoys = initLogElementsEnvoys(n);

        appendToUsingIdleCallback(logElementsEnvoys, logContainer);
    }

    /**
     * Initialize an {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array array} of {@link LogElementEnvoy}
     * @param {number} n - number of envoys we'll create
     * @returns {LogElementEnvoy[]}
     */
    function initLogElementsEnvoys(n) {
        var logElementsEnvoys = [];
        for (var i = 0; i < n; i++) {
            logElementsEnvoys.push(new LogElementEnvoy(i));
        }
        return logElementsEnvoys;
    }

    /**
     * Append every {@link LogElement} to an {@link https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement HTMLElement} using {@link https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback requestIdleCallback} to avoid performance issues
     * @param {LogElementEnvoy[]} logElementsEnvoys
     * @param {HTMLElement} logContainer
     * @throws {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypeError TypeError} if the browser didn't support {@link https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback requestIdleCallback}
     * @returns {void}
     */
    function appendToUsingIdleCallback(logElementsEnvoys, logContainer) {
        if (logElementsEnvoys.length) {
            window.requestIdleCallback(function () {
                var logElementEnvoy = logElementsEnvoys.shift();

                var logElement = logElementEnvoy.create();

                logContainer.appendChild(logElement);

                appendToUsingIdleCallback(logElementsEnvoys, logContainer)
            });
        }
    }
}

/**
 * An {@link http://www.cs.uni.edu/~wallingf/patterns/envoy.pdf envoy} for a specific {@link LogElementEnvoy~logElementConstructor}
 * @param {number} logElementIndex - index that will be used as argument for the {@link LogElementEnvoy~logElementConstructor}
 * @class
 */
function LogElementEnvoy(logElementIndex) {
    /**
     * An {@link https://developer.mozilla.org/en-US/docs/Web/API/HTMLParagraphElement HTMLParagraphElement} with text for debug purpose
     * @typedef {HTMLParagraphElement} LogElement
     * @see {@link LogElementEnvoy~logElementConstructor}
     */

    /**
     * Creates a {@link LogElement}
     * @param {number} i - index for this {@link LogElement}
     * @returns {LogElement}
     */
    function logElementConstructor(i) {
        var logElement = document.createElement('p');
        var currentDate = new Date();
        var logText = "Element n. " + i + " at " + currentDate.getMinutes() + ":" + currentDate.getSeconds() + ":" + currentDate.getMilliseconds();
        logElement.innerText = logText;
        return logElement;
    }

    /**
     * Execute {@link LogElementEnvoy~logElementConstructor} with a {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures closure}
     * @returns {LogElement}
     */
    this.create = function () {
        return logElementConstructor(logElementIndex);
    }
}

/**
 * @global
 * @type {ITSAR}
 */
var $ITSAR = new ITSAR();
