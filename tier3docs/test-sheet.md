## Editors only
This sheet is not published is only for format references
<!--comment-->
<!--- This is an HTML comment in Markdown -->



### highlight words
I need to highlight these ==very important words==. (ver .md)<br>
I need to highlight these <mark>very important words</mark>. (ver .md)

### lists

**lists 1**
``` {linenums="1"}
line_1
line_2
line_3
```

**lists 2**
list
<li>item1</li>
<li>item2</li>
<li>item3</li>

![fo](/doma/storage/UChicago/uc_r2d2_request.png)

<span style="color:blue"> some emphasized markdown text</span><br>
<font color=#0fb503>other color</font><br>
<font color=purple>other color</font><br>
<mark> jello</mark> jello<br>
<ins> jello</ins>: jello<br>

<kbd>haos</kbd>
<kbd>Fancy!</kbd> <br>
==This was marked== <br>
^^This was inserted^^<br>
~~This was deleted~~<br>
 <ins> jello</ins>

<!------------------------------------------------------------------------------------->

## menus dropdown
**## example1 dropdown:simple**


**## example2 dropdown** 
<details open>
<summary>example2 of dropdown: list: not working</summary> <!--no funciona, checar-->

    + markdown list 1
        + nested list 1
        + nested list 2
    + markdown list 2
</details>
<br>

**## example3 dropdown** 
<details open>
<summary>example3 of dropdown:open</summary>
<br>
    Waaa, you see me. I thought I would be hidden ;p .
</details>
<br>

**## example4 dropdown** 
<details open>
<summary>**example1 dropdown: nested dropdown</summary>

<details>
<summary>Try this</summary>

 <details>
 <summary>The other one</summary>

   <details>
   <summary>Ok, try this</summary>
   You got me 😂
   </details>
 </details>
</details>
</details>
<br>

**##example5 dropdown: code** 
<details open>
<summary>example5 of dropdown:code</summary>
<br>
    ruby code
    ```ruby
    def generate_code(number)
        charset = Array('A'..'Z')+ Array('a'..'z')
        Array.new(number){charset.sample }.join
    end
    puts generate_code(20)
    ```
Waaa, you see me. I thought I would be hidden ;p .
</details>