// HSE Theme for Touying
#import "../src/exports.typ": *

#let get-lang(info) = {
  if "lang" in info {
    str(info.lang)
  } else {
    "ru"
  }
}

#let t(info, ru, en) = {
  if get-lang(info) == "en" { en } else { ru }
}

/// Default slide function for the presentation.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    move(
      dx: -2em,
      dy: 0pt,
      grid(
        rows: (95.37pt, 1pt),
        row-gutter: 0pt,
        block(
          width: 100% + 4em,
          height: 100%,
          fill: self.colors.primary,
          inset: (left: 2em + 6.58pt, right: 2em, y: 0pt),
          grid(
            columns: (85.5pt, 1fr, auto),
            align: horizon,
            {
              if self.info.logo != none {
                set image(width: 85.5pt, height: 85.5pt, fit: "contain")
                std.align(top + left, pad(top: 6.58pt, self.info.logo))
              }
            },
            pad(left: 2em, text(
              font: "HSE Sans",
              fill: white,
              weight: "bold",
              size: 24pt,
              utils.call-or-display(self, self.store.header),
            )),
            text(fill: white, utils.call-or-display(
              self,
              self.store.header-right,
            )),
          ),
        ),
        block(
          width: 100% + 4em,
          height: 100%,
          fill: self.colors.gray,
        ),
      ),
    )
  }
  let footer(self) = {
    set std.align(bottom)
    move(
      dx: -2em,
      dy: 0pt,
      grid(
        rows: (1.644pt, 24.665pt),
        row-gutter: 0pt,
        block(
          width: 100% + 4em,
          height: 100%,
          fill: self.colors.primary,
        ),
        block(
          width: 100% + 4em,
          height: 100%,
          fill: white,
          inset: (x: 2em, y: 0pt),
          {
            let cell(..args, it) = components.cell(
              ..args,
              inset: 0pt,
              std.align(horizon, text(font: "HSE Sans", size: 9pt, fill: self.colors.primary, it)),
            )
            grid(
              columns: self.store.footer-columns,
              rows: 100%,
              cell(std.align(left, text(
                font: "HSE Sans",
                size: 9pt,
                weight: "bold",
                fill: self.colors.primary,
                utils.call-or-display(
                  self,
                  self.store.footer-a,
                ),
              ))),
              cell(std.align(center, text(
                font: "HSE Sans",
                size: 9pt,
                weight: "bold",
                fill: self.colors.primary,
                utils.call-or-display(
                  self,
                  self.store.footer-b,
                ),
              ))),
              cell(std.align(right, pad(right: 2em, text(
                font: "HSE Sans",
                size: 9pt,
                weight: "bold",
                fill: self.colors.primary,
                utils.call-or-display(
                  self,
                  self.store.footer-c,
                ),
              )))),
            )
          },
        ),
      ),
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
    config-common(subslide-preamble: self.store.subslide-preamble),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})


/// Centered slide for the presentation.
#let centered-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  touying-slide(self: self, ..args.named(), config: config, std.align(
    center + horizon,
    args.pos().sum(default: none),
  ))
})


/// Title slide for the presentation.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: false),
    config,
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    grid(
      columns: (630fr, 1930fr),
      rows: 100%,
      block(
        width: 100%,
        height: 100%,
        fill: self.colors.primary,
        inset: (top: 6.58pt, left: 0pt, right: 0pt),
        {
          if info.logo != none {
            set image(width: 85.5pt, fit: "contain")
            std.align(center, info.logo)
          }
        },
      ),
      block(
        width: 100%,
        height: 100%,
        fill: white,
        inset: (top: 1.5em, bottom: 2em, left: 4em, right: 3em),
        {
          std.align(center)[
            #set text(fill: self.colors.primary, size: 13.5pt, weight: "bold")
            #if "institution" in info and info.institution != none {
              info.institution
            } else {
              t(info, [Факультет компьютерных наук], [Faculty of Computer Science])
            }
            \
            #if "program" in info and info.program != none {
              info.program
            } else {
              t(info, [Образовательная программа «Программная инженерия»], [Department of Software Engineering])
            }
            \
            #if "doc_type" in info and info.doc_type != none {
              info.doc_type
            } else {
              t(info, [Выпускная квалификационная работа], [])
            }
          ]

          v(0.5fr)
          std.align(center)[
            #if "title" in info and info.title != none {
              text(
                size: 18pt,
                fill: self.colors.primary,
                weight: "bold",
                info.title,
              )
            } else {
              text(
                size: 18pt,
                fill: self.colors.primary,
                weight: "bold",
                t(info, [ТЕМА ВКР НА РУССКОМ ЯЗЫКЕ], [THESIS TITLE]),
              )
            }
            #if get-lang(info) != "en" {
              if "subtitle" in info and info.subtitle != none {
                v(0.3em)
                text(size: 18pt, fill: self.colors.primary, weight: "bold", info.subtitle)
              } else {
                v(0.3em)
                text(size: 18pt, fill: self.colors.primary, weight: "bold", [ТЕМА ВКР НА АНГЛИЙСКОМ ЯЗЫКЕ])
              }
            }
            #if get-lang(info) != "en" {
              if "type" in info and info.type != none {
                v(2em)
                text(size: 13.5pt, fill: self.colors.primary, weight: "bold", info.type)
              } else {
                v(2em)
                text(size: 13.5pt, fill: self.colors.primary, weight: "bold", t(info, [ТИП ВКР], [THESIS TYPE]))
              }
            }
          ]
          v(2fr)
          place(bottom + center, dy: 0em)[
            #set text(fill: self.colors.primary, size: 12pt, weight: "bold")
            #let city = if "city" in info and info.city != none { info.city } else { t(info, [Москва], [Moscow]) }
            #let year = if "year" in info and info.year != none { info.year } else { [2026] }
            #city, #year
          ]
          place(bottom + right, dx: 2em, dy: 0em)[
            #set text(fill: self.colors.primary, size: 12pt, weight: "bold")
            #set std.align(right)
            #if get-lang(info) == "en" [
              #if "author" in info and info.author != none {
                text(fill: self.colors.primary)[#info.author]
              } else {
                text(fill: self.colors.primary)[Full Name]
              }
              \
              #t(info, [Программная инженерия], [Software Engineering])
              #h(0.5em)
              #if "group" in info and info.group != none {
                text(fill: self.colors.primary)[#info.group]
              } else {
                text(fill: self.colors.primary)[BSE123]
              }
            ] else [
              #t(info, [Выполнил студент группы], [Done by the student of group])
              #if "group" in info and info.group != none {
                text(fill: self.colors.primary)[#info.group]
              } else {
                text(fill: self.colors.primary)[#t(info, [БПИXXX], [BSE123])]
              }
              #t(info, [образовательной программы], [of educational program])
              #if "program_code" in info and info.program_code != none {
                info.program_code
              } else {
                [00.00.00]
              }
              «#t(info, [Программная инженерия], [Software Engineering])»
              \
              #if "author" in info and info.author != none {
                text(fill: self.colors.primary)[#info.author]
              } else {
                text(fill: self.colors.primary)[#t(info, [Фамилия Имя Отчество], [Full Name])]
              }
            ]


            \
            #t(info, [Руководитель:], [Supervisor:])
            \
            #if "supervisor_title" in info and info.supervisor_title != none {
              text(fill: self.colors.primary)[#info.supervisor_title ]
            } else {
              text(fill: self.colors.primary)[#t(info, [ДОЛЖНОСТЬ, УЧЕНАЯ СТЕПЕНЬ], [POSITION, ACADEMIC DEGREE]) ]
            }
            \
            #if "supervisor" in info and info.supervisor != none {
              text(fill: self.colors.primary)[#info.supervisor]
            } else {
              text(fill: self.colors.primary)[#t(info, [ФИО], [Full Name])]
            }
            \
            #if "consultant_role" in info and info.consultant_role != none {
              info.consultant_role + ":"
            } else {
              t(info, [Соруководитель / Консультант:], [Co-supervisor / Consultant:])
            }
            \
            #if "consultant_title" in info and info.consultant_title != none {
              text(fill: self.colors.primary)[#info.consultant_title ]
            } else {
              text(fill: self.colors.primary)[#t(info, [ДОЛЖНОСТЬ], [POSITION])]
            }
            #if "consultant" in info and info.consultant != none {
              text(fill: self.colors.primary)[#info.consultant]
            } else {
              text(fill: self.colors.primary)[#t(info, [ФИО], [Full Name])]
            }
          ]
        },
      ),
    )
  }

  self = utils.merge-dicts(self, config-page(margin: 0em))
  touying-slide(self: self, body)
})


/// New section slide for the presentation.
#let new-section-slide(config: (:), body) = touying-slide-wrapper(self => {
  let slide-body = [
    #text(2.5em, weight: "bold", fill: self.colors.primary, utils.display-current-heading(level: 1))
    #v(1em)
    #body
  ]
  touying-slide(self: self, config: config, std.align(center + horizon, slide-body))
})


/// Focus on some content - uses HSE primary blue background.
#let focus-slide(
  config: (:),
  background: auto,
  foreground: white,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if background == auto {
        self.colors.primary
      } else {
        background
      },
      margin: 2em,
    ),
  )
  set text(fill: foreground, size: 1.5em)
  touying-slide(self: self, config: config, std.align(center + horizon, body))
})


/// HSE Theme for Touying
#let hse-theme(
  aspect-ratio: "16-9",
  header: self => utils.display-current-heading(
    level: 1,
    depth: self.slide-level,
    numbered: false,
  ),
  header-right: self => none,
  footer-a: self => {
    let lang = get-lang(self.info)
    let prog-str = if self.info.keys().contains("short_program") and self.info.short_program != none {
      self.info.short_program
    } else {
      self.info.program
    }
    let year-str = if self.info.keys().contains("year") and self.info.year != none {
      utils.markup-text(self.info.year)
    } else {
      "2026"
    }
    let inst-prefix = t(self.info, "ФКН", "FCS")
    let prog-prefix = t(self.info, "ОП", "Program")
    let footer-str = inst-prefix + ", " + prog-prefix + " " + utils.markup-text(prog-str) + ", " + year-str
    pad(left: 2em, footer-str)
  },
  footer-b: self => {
    let lang = get-lang(self.info)
    let author-str = if self.info.keys().contains("short_author") and self.info.short_author != none {
      self.info.short_author
    } else {
      self.info.author
    }
    let footer-str = ""
    if author-str != none { footer-str += utils.markup-text(author-str) }
    if author-str != none and self.info.title != none {
      footer-str += t(self.info, ", ВКР «", ", Thesis \"")
    }
    if self.info.title != none {
      footer-str += utils.markup-text(self.info.title)
      if author-str != none {
        footer-str += t(self.info, "»", "\"")
      }
    }
    footer-str
  },
  footer-c: self => text(
    font: "HSE Sans",
    size: 9pt,
    fill: self.colors.primary,
    context utils.slide-counter.display(),
  ),
  footer-columns: (auto, auto, auto),
  progress-bar: false,
  primary: cmyk(100%, 80%, 0%, 40%),
  secondary: cmyk(95%, 75%, 0%, 0%),
  tertiary: cmyk(0%, 0%, 0%, 50%),
  grey: cmyk(0%, 0%, 0%, 50%),
  grey-light: cmyk(0%, 0%, 0%, 25%),
  grey-lightest: cmyk(0%, 0%, 0%, 10%),
  subslide-preamble: block(
    below: 1.5em,
    text(1.2em, weight: "bold", utils.display-current-heading(level: 2)),
  ),
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 115pt, bottom: 42pt, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: none,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "HSE Sans", size: 14pt, fill: self.colors.primary)
        show heading: set text(fill: self.colors.primary)
        show strong: set text(fill: self.colors.secondary)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      gray: grey,
      gray-light: grey-light,
      gray-lightest: grey-lightest,
      neutral: primary,
      neutral-light: primary,
      neutral-lighter: primary,
      neutral-lightest: rgb("#FFFFFF"),
      neutral-dark: primary,
      neutral-darker: primary,
      neutral-darkest: primary,
    ),
    config-store(
      header: header,
      header-right: header-right,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
      footer-columns: footer-columns,
      progress-bar: progress-bar,
      align: center + horizon,
      subslide-preamble: subslide-preamble,
    ),
    ..args,
  )

  body
}
