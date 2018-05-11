all:
	embedmd chapters/01-first-steps.md              > BOOK.md
	embedmd chapters/02-advanced-data-selection.md >> BOOK.md
	embedmd chapters/03-numerical-recipes.md       >> BOOK.md
