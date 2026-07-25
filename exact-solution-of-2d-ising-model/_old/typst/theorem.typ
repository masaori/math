#let theorem_counter_str = (loc) => {
  let heading_counter = counter(heading)
  let theorem_counter = counter(figure.where(kind: "lib:theroem"))
  let heading_counter_number = heading_counter.at(loc)
  let theorem_counter_number = theorem_counter.at(loc)
  let number = heading_counter_number + theorem_counter_number
  return numbering("1.1", ..number)
}

#let block_with_counter = (
  title,
  name,
  fill,
  inset,
  radius,
  content,
) => {
  let title_line = () => {
    let counter_str = theorem_counter_str(here())
    let title_line
    if name == none {
      title_line = $bold(title)$ + " " + counter_str
    } else {
      title_line = $bold(title)$  + " " + counter_str + " ("+ name + ") "
    }
    return title_line
  }

  return figure(
    kind: "lib:theroem",
    supplement: title,
  )[#block(
    width: 30cm,
    breakable: false,
    fill: fill,
    inset: inset,
    radius: radius,
    align(
      left,
      [
        #context title_line():
      ] + "\n" + content
    )
  )]
}

#let theorem = (name, content) => block_with_counter(
  "Theorem",
  name,
  rgb("#ffffcb"),
  8pt,
  4pt,
  content
)

#let definition = (name, content) => block_with_counter(
  "Definition",
  name,
  rgb("#d4d4d4"),
  8pt,
  4pt,
  content
)

#let claim = (name, content) => block_with_counter(
  "Claim",
  name,
  rgb("#bae8ff"),
  8pt,
  4pt,
  content
)

#let remark = (content) => block_with_counter(
  "Remark",
  none,
  rgb("#f0f0f0"),
  8pt,
  4pt,
  content
)

#let proof = (content) => box(
  width: 100%,
  fill: rgb("#f0f0f0"),
  inset: 8pt,
  radius: 4pt,
  [
    $bold("Proof:")$

    #content
  ]
)

#let note = (content) => box(
  width: 100%,
  fill: rgb("#ffebd1"),
  inset: 8pt,
  radius: 4pt,
  [
    #set text(size: 8pt)
    $bold("Note:")$
    #content
  ]
)

#let theorem_rules(qed-symbol: $qed$, doc) = {
  show figure.where(kind: "lib:theroem"): it => it.body
  set heading(numbering: "1.1.")
  show heading: it => {
    return [
      #context counter(figure.where(kind: "lib:theroem")).update(0)
      #it
    ]
  }

  show ref: it => {
    if it.element == none {
      return it
    }
    if it.element.func() != figure {
      return it
    }
    if it.element.kind != "lib:theroem" {
      return it
    }

    let supplement = it.element.supplement
    if it.citation.supplement != none {
      supplement = it.citation.supplement
    }

    let loc = it.element.location()
    return link(
      it.target,
      [#supplement #theorem_counter_str(loc)]
    )
  }

  doc
}


// 
// Examples.
// 

#show: theorem_rules.with(qed-symbol: $qed$)


= A <head_1>
== B

ここは @head_1 の
あらすじ @thorem_1

=== C

#figure()[
  This is Figure
]<fig_2>

#block_with_counter(
  "Theorem",
  none,
  rgb("#ff0000"),
  8pt,
  4pt,
)[hoge hogehogehogehogehogehogehoge

  hoge hogehogehogehogehogehogehoge
  
  hoge hogehogehogehogehogehogehoge
  
  hoge hogehogehogehogehogehogehoge
]<thorem_1>

#block_with_counter(
  "Theorem",
  "Name of this",
  rgb("#ff0000"),
  8pt,
  4pt,
)[
  hogehogehogehogehogehogehogehoge
]
#block_with_counter(
  "Theorem",
  "Name of this",
  rgb("#ff0000"),
  8pt,
  4pt,
)[
  hoge
]

== D

=== E

#block_with_counter(
  "Theorem",
  "Name of this D",
  rgb("#ffaaaa"),
  8pt,
  4pt,
)[
  hoge
]<theoremD>

#block_with_counter(
  "Theorem",
  "Name of this E",
  rgb("#aaaaaa"),
  8pt,
  4pt,
)[
  hoge
]

#block_with_counter(
  "Theorem",
  "Name of this E",
  rgb("#aaaaaa"),
  8pt,
  4pt,
)[
  hoge
]

=== F

#block_with_counter(
  "Theorem",
  "Name of this F",
  rgb("#aaaaaa"),
  8pt,
  4pt,
)[
  hoge
]



#figure()[
  phi = 1
]<fig_1>

#theorem("aaa")[
  phi = 1
  "AAAAA"
  
  $1234$

  @fuga

  @hoge

  $
  "AAAAA"
  $
]<fuga>

#claim(none)[
  $
    1 * 3 - 1 = 2
  $
]<hoge2>
#claim(none)[
  $
    1 * 3 - 1 = 2
  $
]<hoge>
