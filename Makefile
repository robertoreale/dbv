all:
	embedmd chapters/first-steps.md              > BOOK.md
	embedmd chapters/advanced-data-selection.md >> BOOK.md
	embedmd chapters/numerical-recipes.md       >> BOOK.md
