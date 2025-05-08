#import "@preview/kunskap:0.1.0": *

#let tiny = it => smallcaps(lower(it))

#let date = datetime(
  year: 2025,
  month: 5,
  day: 8,
).display("[month repr:long] [day padding:none], [year]")

#show: kunskap.with(
  title: "A Category-Theoretic Treatment of Petri Nets in Biology",
  author: "Ananth Venkatesh",
  date: date,
  header: "ES.7013 Introductory Biology"
)

= Background

#lorem(50)

= Relevance

// What is important about the paper?
// Why did you choose this paper?

#lorem(100)

= Applications

// Does this paper incorporatea any topics that we discussed in the class?
// Does this paper have any overlap with your interests, major, etc?

#lorem(50)
