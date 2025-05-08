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

This report aims to summarize the findings and methodology of "Using Petri Net Tools to Study Properties and Dynamics of Biological Systems" @peleg_2005.
This paper focuses on the applicability of a conceptual mathematical framework, called "Petri Nets", to describe and simulate biological processes.

The aim of using these tools is that we can gain a high-level understanding of how a biological system operates and make predictions as to its outputs.
When these predictions do not match experimental results, we know that we need to extend our model.

Petri Nets in particular also allow researchers to verify properties of a biological system and directly simulate the system at varying levels of abstraction, even when all the details are not fully understood.
The key insight comes from breaking down a complex chain of processes into a composition of simpler individual components.

== Definitions

Petri Nets were originally constructed using the mathematical theory of graphs to represent complex systems involving transition states.
In many systems, there exist a finite set of distinct states and transitions that can move objects between those states provided a set of conditions is met.
Petri Nets represent this as a graph with two types of nodes (this is known as a "bipartite graph"): one for evaluating conditions (e.g. whether a sufficient amount of reactants exist for a reaction to take place) and one for activities (e.g. the reaction triggered by the previous condition).
Petri Nets are _directed_ graphs, meaning there are arrows connecting condition nodes to activity nodes and vice versa.

Condition nodes are referred to as "places", and activity nodes are referred to as "transitions".
The arrows connecting them are called "arcs".

The utility of Petri Nets comes from their ability to simulate biological processes using "tokens", which are objects that flow through the graph.
Arcs are assigned a positive integer threshold, usually one.
For arcs connecting a place to a transition, this number represents the quantity of tokens that must be present in the place to trigger the transition.
When this number of tokens is reached, they are removed from the place and the transition "fires".
The number on arcs from transitions to places determines the number of tokens that are generated in the place when the transition is fired.

#figure(caption: [An example of a Petri Net (places are open circles and transitions are black rectangles) with all arcs having unit threshold by default @chen_1992])[
  #image("assets/img/petri.png")
]

== Category Theory

Though Petri Nets were originally presented using the mathematical theory of graphs, there turns out to be a better interpretation based on a more abstract mathematical structure, known as a "category".
Simply put, a category is a collection of objects (things) and morphisms (transformations between things).
We can encode a Petri Net as one of a few special types of categories, but the general idea is to do the following @baez_2021:

1. Take all possible combinations of places in a Petri Net with the number of tokens they could contain (a configuration) and make each a single object in a category
2. For each transition of the Petri Net, define a morphism that maps from one configuration to another (moving tokens from place to place)
3. We can construct configurations using a binary operation that combines places known as a "symmetric monoidal product"

The third point refers to the fact that we can specify configurations by combining existing configurations.
For example, if $A$ is the configuration in which place A has one token and every other place has zero tokens and $B$ is the corresponding configuration for place B, the configuration in which both $A$ and $B$ have one token and every other place has no tokens is $A times.circle B$.
By symmetry, we mean that $A times.circle B = B times.circle A$.
We can add multiple tokens by combining the same object with itself that number of times.
For example, to add two tokens to $A$, we can do $A times.circle A$

Part of the reason this formalism is helpful is because it allows us to reason about properties of Petri Nets using higher mathematical structures, known as "monoids" (single object categories).
We can also talk about _composition_, or the effect of applying one transition after another.
Lastly, we can encode multiple Petri Nets as separate categories and talk about maps between them, allowing us to discover connections between seemingly unrelated biological pathways by uncovering fundamental symmetries.

#figure(caption: [Category theory allows us to compose Petri Nets together, by considering some to be \"sub categories\" of each other, meaning all the objects of the category of the tiny Petri Nets are contained in the larger category of the overall Petri Net @master_2021])[
  #image("assets/img/cat.png")
]

= Relevance

Petri Nets have a plethora of use cases in biology, mainly related to analyzing biological pathways and related systems.
Examples include metabolism pathways, modeling of enzyme-substrate complexes, and analyzing reversible reactions in cellular conditions.
This mathematical framework allows biologists to answer questions such as:

1. Can all processes in this pathway be executed?
2. Is this pathway stable (bounded)? Are there places that could accumulate an infinite number of tokens?
3. What configurations of this Petri Net are valid (reachable)?
4. Are there invariants (places where the total number of tokens is constant)?
5. Are there cycles in the graph (circuits) that can be viewed as independent components?

Each of these conditions translates to gaining biological insight into the process at hand.
The first condition tells us which pathways are important and which can be neglected.
The second can identify, for example, toxic accumulations of some compound in a cell.
The third condition allows us to understand which states the pathway can exist in and which are not physically possible.
The last two conditions focus on high-level properties of the Petri Net, which can uncover shared structures and allow us to reason about smaller components in the larger system.

The paper mentions several intriguing applications of Petri Nets and related extensions to model a wide array of biological systems, including glycolysis, genetic inheritance, infectious disease spread, and protein phosphorylation.
The authors build on these previous results by extrapolating several key properties of biological processes that they believe make Petri Nets an ideal model:

1. Differing levels of abstraction
2. Individual and population-level effects
3. Variation within a population sample
4. Biochemical reactions (in metabolic processes, for example)
5. Process inhibition
6. Possibility of alternative pathways
7. Concurrent and continuous processing of inputs and production of outputs

The authors attempt to test the applicability of Petri Nets to a diverse set of biological case studies from three domains: malaria invasion of human host cells, effects of tRNA mutations on protein translation, and the pathway of the gemcitabine drug in a human cell.

#figure(caption: [Pathway of the gemcitabine drug in human cells represented as a Petri Net, from @peleg_2005])[
  #image("assets/img/pathway.png")
]

The authors are able to encode these processes using various extensions of the Petri Net model, and they test introducing delayed and probabilistic transitions to more accurately model biological systems.
They conclude that Petri Nets are a powerful framework for modeling biological systems, and that each of the core properties they identified of biological systems can be well represented in the Petri Net formalism.
They do note some limitations of Petri Nets which can make it hard to, for example, approximate non-linear functions like the Michaelis--Menten equation, though they note that further extensions of the model can account for this.

Unlike other papers on Petri Nets, the authors aim to analyze the applicability of the framework to a great variety of biological problems.
Their analysis reveals that extensions of the base Petri Net model are necessary for many types of phenomena.
For example, modeling the difference in the behavior of normal and mutant alleles requires differentiating tokens, resulting in what is called a colored (or typed) Petri Net.

The authors note some fundamental limitations of the Petri Net model, which center around its lack of applicability to processes with an extremely large number of possible states (e.g. the set of all possible spatial configurations of $n$ molecules).
However, for processes consisting of a chain of atomic steps and those with relatively few distinct states, the Petri Net model provides a novel conceptual framework for identifying key properties about the system.

= Context

I chose this paper to highlight the ways in which mathematical tools are providing biologists with formal methods for verifying and analyzing complex systems.
While biology is fundamentally based on experimental results, these tools allow for theories to be quickly tested and developed within a theoretical framework that best represents how we conceptualize and think about the real world that we observe through experimentation.
In addition to the theory being influenced by experiment, theoretical results can motivate experiments themselves.
For example, the identification of key places in a Petri Net where tokens are conserved may correspond to steady states of a biochemical reaction that can be further analyzed to understand a pathway.

The paper studies many phenomena similar to those encountered in ES.7013.
For example, signal transduction pathways are frequently used to create Petri Nets for analyzing the behavior of human cells in response to external signals.
In the paper, the response in human cells elicited by the gemcitabine drug is studied, which involves protein transport, phosphorylation, and dephosphorylation.
The process by which tRNA is converted to mRNA, resulting in amino acid acylation, is also studied in the paper using the Petri Net formalism.
Thus, many of these fundamental concepts in biology can be well represented in the Petri Net graph structure.

I am particularly interested in the paper due to its applicability of the Petri Net model, which has numerous category theoretic interpretations.
I enjoy thinking about the applicability of abstract mathematical ideas, especially in category theory, to solving problems in scientific disciplines, and I was surprised to discover an application of category theory in biology.
The fact that Petri Nets have the ability to model such a broad array of phenomena, both within biology and even in other disciplines, is a consequence of the #link("https://ncatlab.org/nlab/show/nPOV")[higher structures point of view] (nPOV).

#block(breakable: false)[
  #bibliography("refs.bib", title: "References")
]
