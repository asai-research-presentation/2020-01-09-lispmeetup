MathJax.Hub.Config({
    // Only one of the two following lines, depending on user settings
    // First allows browser-native MathML display, second forces HTML/CSS
    config: ["MMLorHTML.js"],
    // jax: ["input/TeX"],
    //  jax: ["input/TeX", "output/HTML-CSS"],
    jax: ["input/TeX","output/NativeMML"],
    extensions: ["tex2jax.js","TeX/AMSmath.js","TeX/AMSsymbols.js",
                 "TeX/noUndefined.js"],
    tex2jax: {
        inlineMath: [ ["$","$"], ["\\(","\\)"] ],
        displayMath: [ ['$$','$$'], ["\\[","\\]"], ["\\begin{displaymath}","\\end{displaymath}"] ],
        skipTags: ["script","noscript","style","textarea","pre","code"],
        ignoreClass: "tex2jax_ignore",
        processEscapes: false,
        processEnvironments: true,
        preview: "TeX"
    },
    showProcessingMessages: true,
    displayAlign: "center",
    displayIndent: "2em",

    "NativeMML": {
        scale: 120,
    },
    MMLorHTML: {
        prefer: {
            MSIE:    "MML",
            Firefox: "MML",
            Opera:   "HTML",
            other:   "HTML"
        }
    }
});
