#import "@preview/drafting:0.2.0": *


// Paper and page layout
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

// Colors
#let colors = (
  sky: rgb("68BED8"),
  carrot: rgb("FC9706"),
  carrot-lighter: rgb(252, 151, 6, 40%),
  midnight: rgb("023047"),
  midnight-lighter: rgb("0B6082"),
  saffron: rgb("FFC729"),
  pistachio: rgb("A0AF12"),
  pistachio-darker: rgb("546800"),
  pistachio-lighter: rgb(160, 174, 18, 15%)
)

// Fonts
#let sans-fonts = (
    "GT Planar Trial",
    "Franklin Gothic"
  )

// Fonts used for headings and body copy
#let serif-fonts = (
  "Farnham Text",
  "Georgia",
)

#let tabular-fonts = (
  "IBM Plex Sans"
)

// Page elements
#let format-footer(content) = {
  set text(font: sans-fonts, size: 8pt, fill: rgb(0%,0%,0%,40%))
  
  block(width: 175%, {
  set align(right)
  line(length: 5em, stroke: 0.25pt+rgb(0%, 0%, 0%, 25%));
  content})
}

#let wideblock(content) = block(
  width:100% + column-widths.gutter + column-widths.secondary, content)

 #let table-grid(x, y) = (
  left: if x > 0 { 0.5pt } else { none },
  right: none,
  top: if y > 0 { 0.5pt } else { 0.5pt },
  bottom: 0.5pt
  )


// Markup functions
#let define(content) = {
  
  set text(fill: colors.pistachio-darker)
  underline(stroke: 13pt + colors.pistachio-lighter, offset: -3pt, evade: false, background: true, content)
}

#let template(
  title: [Paper Title],
  shorttitle: none,
  subtitle: none,
  authors: (
    (
      name: "First Last",
      role: none,
      organization: none,
      location: none,
      email: none
    ),
  ),
  date: datetime.today(),
  document-number: none,
  draft: false,
  distribution: none,
  abstract: none,
  publisher: none,
  toc: false,
  bib: none,
  footer-content: none,
  doc
) = {
  // Document metadata
  set document(title: title, author: authors.map(author => author.name))

  // Just a suttle lightness to decrease the harsh contrast
  set text(fill:luma(30))

  // Tables and figures
  show table: it => {
    v(1em)
    set par(justify: false, leading: 0.675em)
    set text(font: tabular-fonts, weight: 300)
    it
    v(1em)
  }
  show table: set table(stroke: table-grid, inset: 0.5em)
  show table.cell.where(y: 0): set text(weight: 900)


  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure.caption: set align(left)
  show figure.caption: set text(font: sans-fonts)

  show figure.where(kind: table): set figure.caption(position: top)
show figure.where(kind: table): set figure(supplement: text(fill: colors.carrot, weight: 900, [Table]), numbering: n => text(fill: colors.carrot, weight: 900, [#n]))
  show figure.where(kind: table): set figure.caption(position: top)
  
  show figure.where(kind: image): set figure(supplement: text(fill: colors.carrot, weight: 900, [Fig]), numbering: n => text(fill: colors.carrot, weight: 900, [#n]))
  show figure.where(kind: image): set figure.caption(position: top)

  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: [Code], numbering: "1")
  show raw: set text(font: sans-fonts, size: 10pt)

  // Equations
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  show link: set text(fill: colors.midnight-lighter)
  show link: set underline(stroke: 0.5pt+colors.sky, evade:false, offset: 1.6pt)
  show link: underline

  // Lists
  set enum(
    indent: 1em,
    body-indent: 1em,
  )
  set enum(numbering: n => text(font: sans-fonts, fill: colors.sky, [#n.]))
  show enum: set par(justify: false)

  set list(
    indent: 1em,
    body-indent: 1em,
  )

  show list: set par(justify: false)
  set list(marker: text(font: sans-fonts, fill: colors.sky, "◯"))
  

  // Headings
  set heading(numbering: none,)
  show heading.where(level:1): it => {
    set par(leading: 4pt, justify: false)
    text(font: sans-fonts, size: 27pt, weight: "black", it)
    v(0.0625in)
  }

  show heading.where(level:2): it => {
    v(0.125in + 0.1875in, weak: true)  
    line(length: 100%, stroke: 2pt + black)
    set par(leading: 16pt)
    set text(font: sans-fonts, size: 8.5pt, weight: "black", tracking: 0.075em)
    upper(it) 
    v(0.25in)
  }

  show heading.where(level:3): it => {
    v(0.3125in, weak:true)
    line(length: 100%, stroke: black + 0.25pt)
    set par(leading: 16pt)
    text(font: sans-fonts, size: 9pt,weight:"semibold", it)
    v(0.25in)
  }

  show heading: it => {
    if it.level <= 3 {it} else {}
  }

  // Page setup
  set page(
    paper: paper.type,
    margin: body-margins, 
    header: none,
    
    footer: context {
      format-footer([#counter(page).display()])
    },
    background: if draft {rotate(45deg,text(font:"Gill Sans MT",size:200pt, fill: rgb("FFEEEE"))[DRAFT])}
  )

  set par(
    justify: true,
    leading: 6pt,
    first-line-indent: 0em,
  )
  show par: set block(
    below: 1.2em
  )

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
    if document-number != none {document-number}
  })
  

  if abstract != none {abstractblock(abstract)}
  if toc {tocblock()}

  // Finish setting up sidenotes
  set-page-properties()

  set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: column-widths.secondary, 
    margin-left: paper.width - (page-margins.right + column-widths.primary + column-widths.secondary),
  )

  // Body text
  set text(
    font: serif-fonts,
    style: "normal",
    weight: "regular",
    hyphenate: true,
    size: 10pt
  )

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
