/***********************************************************
* SWITCHBOX TYPST THEME
***********************************************************/

#import "@preview/drafting:0.2.0": *


////////////////////////////////////////////////////////////
// PAPER AND PAGE LAYOUT
////////////////////////////////////////////////////////////

#let paper = (
  type: "us-letter",
  width: 8.5in,
  height: 11in
)

#let page-margins = (
  top: 0.75in,
  left: 0.75in,
  right: 0.75in,
  bottom: 1.0in
) 

#let column-widths = (
  primary: 3.875in,
  secondary: 2.42in, // Ought to be 2.4375
  gutter: 0.6875in
)

#let body-margins = (
  top: page-margins.top,
  left: page-margins.left,
  right: page-margins.right + column-widths.secondary + column-widths.gutter,
  bottom: page-margins.bottom
)


////////////////////////////////////////////////////////////
// COLORS
////////////////////////////////////////////////////////////

#let colors = (
  sky: rgb(104, 190, 216) ,              // #68BED8
  carrot: rgb(252, 151, 6),              // "FC9706"
  carrot-lighter: rgb(252, 151, 6, 40%), 
  midnight: rgb(2, 48, 71),              // "#023047"
  midnight-lighter: rgb(11, 96, 130),    // "#0B6082"
  saffron: rgb(255, 199, 41),            // "#"FFC729"
  pistachio: rgb(160, 175, 18),          
  pistachio-darker: rgb(84, 104, 0),     // "#546800"
  pistachio-lighter: rgb(160, 174, 18, 15%)
)

////////////////////////////////////////////////////////////
// FONTS
////////////////////////////////////////////////////////////

// Headings, notes, captions
#let sans-fonts = (
    "GT Planar",
    "GT Planar Trial",
    "Franklin Gothic"
  )

// Body text
#let serif-fonts = (
  "Farnham Text",
  "Georgia"
)

// Tables
#let tabular-fonts = (
  "IBM Plex Sans"
)

#let code-fonts = {
  "SF Mono"
}

////////////////////////////////////////////////////////////
// PAGE ELEMENTS: TEXT & LAYOUT
////////////////////////////////////////////////////////////

// Body paragraph text
// ==================
#let body-par-params = (
  font: serif-fonts,
  weight: 400,
  style: "normal",
  size: 10pt,
  leading: 6pt,
  justify: true,
  hyphenate: true,
  first-line-indent: 0em,
  vabove: 0.12in,
  vbelow: 0.12in, // Guidance says 0.12in but this is too thin.
  fill: luma(30))

#let format-body-par(content) = {
  block(width: 100%,
    below: body-par-params.vbelow, above: body-par-params.vabove,

    par(first-line-indent: body-par-params.first-line-indent,
      leading: body-par-params.leading, 
      justify: body-par-params.justify,

      text(font: body-par-params.font, 
        size: body-par-params.size, 
        weight: body-par-params.weight,
        style: body-par-params.style, 
        hyphenate: body-par-params.hyphenate,
        fill: body-par-params.fill, 
        content)))
}

// Title and top-matter
// ====================
#let title-params = (font: sans-fonts, size: 32, weight: 900, fill: black)

// Footer: Right-aligned page number with overline
#let format-footer(content) = {
  set text(font: sans-fonts, size: 8pt, fill: rgb(0%,0%,0%,40%))
  
  block(width: 175%, {
  set align(right)
  line(length: 5em, stroke: 0.25pt+rgb(0%, 0%, 0%, 25%));
  content})
}

// Headings
// ========
#let heading-numbering = none

#let heading-params = (  
  h1: (font: sans-fonts, 
       size: 27pt, 
       leading: 4pt, 
       tracking: 0em,
       weight: "black", 
       fill: black, 
       case: it => { it },
       vabove: 1.2em, 
       vbelow: 0.0625in, 
       overline: (stroke: none, vbelow: 0em)),

  h2: (font: sans-fonts, 
        size: 8.5pt, 
        tracking: 0em,
        leading: 7.5pt,
        weight: "black", 
        fill: black,
        case: it => { upper(it) },
        vabove: 0.125in + 2em, 
        vbelow: 0.25in,
        overline: (stroke: 2pt+black, vbelow: 0.1875in - 1em)),

  h3: (font: sans-fonts, 
        size: 9pt, 
        tracking: 0em,
        leading: 7pt, 
        weight: "semibold", 
        fill: black, 
        case: it => { it }, 
        vabove: 0.3125in, 
        vbelow: 0.25in,
        overline: (stroke: 0.25pt+black, vbelow: 0.1875in - 1em))
)

#let format-heading(level) = {
  (h) => {
    let hl = heading-params.at(level)

    set block(width: 100%,
      stroke: (top: hl.overline.stroke), 
      above: hl.vabove,
      inset: (top: hl.overline.vbelow))
      set par(leading: hl.leading, justify: false)
      set text(font: hl.font, 
        size: hl.size, 
        weight: hl.weight, tracking: hl.tracking)
    
      (hl.case)(h) 
    v(hl.vbelow, weak: level != "h1")
    }
}


// Hyperlinks
// ==========
#let body-link-colors = (
  text: colors.sky, 
  underline: colors.midnight-lighter)

#let format-body-links(content) = {
  set text(fill: body-link-colors.underline)
  set underline(stroke: 0.5pt+body-link-colors.text, evade: false, offset: 1.6pt)
  underline(content)
}


// Number lists
// ============
#let enum-params = (
  // 0.375in - approx width of number
  // the way typst does enum indents is a little goofy
  body-indent: 0.375in - 1.5em, 
  first-line-indent: 0in,
  justify: false,
  vabove: body-par-params.vabove,
  vbelow: body-par-params.vbelow,
  // This is spec, but looks pretty bad, and only works if you abuse list
  // markdown. 
  // See: https://typst.app/docs/reference/model/list/#parameters-spacing
  vbetween: 0.05in,  
  num-font: sans-fonts,
  num-font-weight: 400,
  num-font-color: colors.sky
)

#let enum-numbering = n => {
  text(font: enum-params.num-font,
        weight: enum-params.num-font-weight, fill: enum-params.num-font-color, [#n.])
}

#let format-enum(content) = {
  block(above: enum-params.vabove, 
    below: enum-params.vbelow, 
    par(justify: enum-params.justify, content))
}

// Bullet lists
// ============
#let list-params = (
  body-indent: 0.3125in - 1.5em,
  first-line-indent: 0in,
  justify: false,
  vabove: 0.12in,
  vbelow: 0.12in,
  // This is spec, but looks pretty bad, and only works if you abuse list
  // markdown. 
  // See: https://typst.app/docs/reference/model/list/#parameters-spacing
  vbetween: 0.05in,
  num-font: sans-fonts,
  marker: text(font: sans-fonts, fill: colors.sky, "◯")
)

#let format-list(content) =  {
  block(above: list-params.vabove, 
    below: list-params.vbelow, 
    par(justify: list-params.justify, content))
}

// Widebox
// =======
// Content that spans the whole page (for wide figures, etc.)
#let wideblock(content) = block(
  width:100% + column-widths.gutter + column-widths.secondary, content)


// Draft watermark
// ===============
#let format-draft-mark(draft) = {
  if draft {
      rotate(45deg, 
        text(font: sans-fonts, size:200pt, fill: rgb(0, 0, 0, 5%), [DRAFT]))
  }
}

////////////////////////////////////////////////////////////
// PAGE ELEMENTS: TABLES & FIGURES
////////////////////////////////////////////////////////////
// Tables
// ======
 #let table-grid(x, y) = (
  left: if x > 0 { 0.5pt } else { none },
  right: none,
  top: if y > 0 { 0.5pt } else { 0.5pt },
  bottom: 0.5pt
  )

#let format-table(it) = { 
  //set table(stroke: table-grid, inset: 0.5em)
  show table.cell.where(y: 0): set text(weight: 900)
  set par(justify: false, leading: 0.675em)
  set text(font: tabular-fonts, weight: 300)
  it
}

// Figures
// =======
// Put captions on top.
#let format-figure(it) = {
  it.caption
  it.body
}

// Figure captions 
// ===============
// TODO: Change upper to small caps when I figure out how to get 
// this working (hopefully w/ licensed GT Planar)

#let format-captions(it) = {
    // Print the fig type label
    let fig-kind = if (it.kind == table) {
      upper("tab")
    } else if (it.kind == raw) {
      upper("listing")
    } else {
      upper("fig")
    }

    set par(leading: 4pt)
    set align(left)  
    set text(font: sans-fonts, fill: colors.carrot, weight: 900)  
    [#fig-kind 
     #counter(figure.where(kind: it.kind)).display(it.numbering) 
     #h(0.5em)]
    set text(fill: rgb(0, 0, 0, 40%), weight: 400)
    it.body
  }

////////////////////////////////////////////////////////////
// PAGE ELEMENTS: SIDENOTES
////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////
// TEXT MARKUP FUNCTIONS
////////////////////////////////////////////////////////////

// Definitions
#let define(content) = {  
  set text(fill: colors.pistachio-darker)
  underline(stroke: 13pt + colors.pistachio-lighter, offset: -3pt, evade: false, background: true, content)
}

// Last word.
#let icon = {
  box(inset: (left: 1pt), image("icon-carrot.png", height: 0.75em))
}


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// TEMPLATE BEGINS HERE
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

#let template(
  title: none,
  shorttitle: none,
  subtitle: none,
  authors: none,
  date: none,
  draft: false,
  abstract: none,
  publisher: none,
  toc: false,
  bib: none,
  doc
) = {
  // Document metadata
  set document(title: title, author: authors.map(author => author.name))

  // Page layout
  set page(
    paper: paper.type,
    margin: body-margins, 
    header: none,
    footer: context {
      format-footer([#counter(page).display()])
    },
    background: format-draft-mark(draft)
  )

  // Tables and figures
  show figure.caption: format-captions
  show figure: format-figure

  set table(stroke: table-grid, inset: 0.5em)
  show table: format-table

  // Hyperlinks
  show link: format-body-links

  // Equations
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Numbered Lists
  set enum(
    indent:  enum-params.first-line-indent,
    body-indent: enum-params.body-indent, 
    numbering: enum-numbering,
    spacing: enum-params.vbetween
  )
  show enum: format-enum

  // Bullet Lists
  set list(
    indent: list-params.first-line-indent,
    body-indent: list-params.body-indent,
    spacing: list-params.vbetween,
    marker: list-params.marker
  )

  show list: format-list  

  // Headings
  set heading(numbering: heading-numbering)
 
  show heading.where(level:1): format-heading("h1")
  show heading.where(level:2): format-heading("h2")
  show heading.where(level:3): format-heading("h3")
 
  show heading: it => { if it.level <= 3 {it} else {} }


  // Frontmatter
  let titleblock(title: none,subtitle: none,) = wideblock({
    
      set text(
        hyphenate: false,
        size: 32pt,
        font: sans-fonts,
        weight: 900,
        fill: black
      )

      set par(
        justify: false,
        leading:0.2em,
        first-line-indent: 0pt
      )
      title
      set text(size: 14pt, weight: "bold")
      subtitle
    })
  let authorblock(authors) = wideblock({
    set text(font: sans-fonts, size: 10pt)
    v(1em)
    for i in range(calc.ceil(authors.len() / 3)) {
      let end = calc.min((i + 1) * 3, authors.len())
      let is-last = authors.len() == end
      let slice = authors.slice(i * 3, end)
      grid(
        columns: slice.len() * (1fr,),
        gutter: 11pt,
        ..slice.map(author => align(left, {
          set text(weight: 400, fill: colors.sky)
          upper(author.name)
          set text(weight: 300, fill: black)
          if "role" in author [
            \ #author.role
          ]
          if "organization" in author [
            \ #author.organization
          ]
          if "email" in author [
            \ #author.email
          ]
        }))
      )

      if not is-last {
        v(16pt, weak: false)
      }
    }})
  let abstractblock(abstract) = wideblock({
      set text(font: serif-fonts)
      set par(hanging-indent: 3em)
      h(3em)
      abstract
    })
  let tocblock() = wideblock({
      set text(font: serif-fonts)
      outline(indent:1em,title:none,depth:2)
    })

  titleblock(title:title, subtitle:subtitle)
  authorblock(authors)
  text(size:11pt,font: sans-fonts,{
    linebreak()
    if date != none {upper(date.display("[month repr:long] [day], [year]"))}
  })
  

  if abstract != none {abstractblock(abstract)}
  if toc {tocblock()}

  // Finish setting up sidenotes
  set-page-properties()

  set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: column-widths.secondary, 
    margin-left: column-widths.gutter + page-margins.left
  )

  // Body text
  show: par => format-body-par(par)

  doc

  show bibliography: set text(font:sans-fonts)
  show bibliography: set par(justify:false)
  set bibliography(title:none)
  if bib != none {
    heading(level:1,[References])
    bib
  }
}

/* Sidenotes
Display content in the right margin with the `note()` function.
Takes 2 optional keyword and 1 required argument:
  - `dy: length` Adjust the vertical position as required (default `0pt`).
  - `numbered: bool` Display a footnote-style number in text and in the note (default `true`).
  - `content: content` The content of the note.
*/
#let notecounter = counter("notecounter")

#let note(dy:-2em, numbered:true, content) = {
  if numbered {
    notecounter.step()
    text(weight:"black", 
    fill: colors.carrot,
     {
      underline(stroke: 1pt+colors.carrot-lighter,
      offset: -1pt,
        super(notecounter.display())) 
    " "})
  }
  text(size:8pt, font: sans-fonts, weight: "regular", 
  fill: rgb(0%,0%,0%, 40%),
    margin-note(if numbered {
      text(weight:"regular", font: sans-fonts, fill: colors.carrot,
          { notecounter.display()
          "        "
         })
        content
  } else {
    content
  }, dy:dy))
  }

/* Sidenote citation
Display a short citation in the right margin with the `notecite()` function.
Takes 2 optional keyword and 1 required argument.
  - `dy: length` Adjust the vertical position as required (default `0pt`).
  - `supplement: content` Supplement for the in-text citation (e.g., `p.~7`), (default `none`).
  - `key: label` The bibliography entry's label.

CAUTION: if no bibliography is defined, then this function will not display anything.
*/
#let notecite(dy:-2em,supplement:none,key) = context {
  let elems = query(bibliography)
  if elems.len() > 0 {
    cite(key,supplement:supplement,style:"ieee")
    note(
      cite(key,form: "full",style: "template/short_ref.csl"),
      dy:dy,numbered:false
    )
  }
}
