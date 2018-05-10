all:
	embedmd manuscript/first-steps.md              > BOOK.md
	embedmd manuscript/advanced-data-selection.md >> BOOK.md
	embedmd manuscript/numerical-recipes.md       >> BOOK.md
