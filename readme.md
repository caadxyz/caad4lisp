### caad4lisp: a autolisp tool for architectural design

version:           v0.001 dev alpha  
powered by:        caad.xyz  
required:          autolisp  
cross platform:    Mac Windows   
cross cad software:AutoCAD IntelliCAD BricsCAD ...   

**Utility**: General utility Library    
**Geometry**: Geometric algorithm Library  
**Wall**: architectural wall element library and drawing tools  
**Opening**: architectural opening element drawing tools  
**axis**: architectural axis element drawing tools  
**dimension** architectural dimension tools  

### Install & How to use  

**Add a caad4lisp Path to the Support File Search Paths**  
1. Click the Application menu  Options.
1. In the Options dialog box, Files tab, select Support File Search Path.
1. Click Add.
1. Click Browse.
1. In the Browse for Folder dialog box, browse to and select the **caad4lisp** folder to add. Click OK.
1. In the Options dialog box, click OK.

**Load caad4lisp plugin in cad software**

In cad commandline type:  
```
(load "caad.lsp")
```

If your autocad version is 2015 or above 2015+  set `(setq Conf-AutoCAD-Version "2015+")` in `caad.lsp` file.

----

### Develop & Compile

* Using ASDF to setup developing environment
* Using CODEX to compile documentation

