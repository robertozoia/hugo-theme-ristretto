// The example site is its own Go module on purpose. Go omits any subdirectory
// that has its own go.mod from the parent module, so nothing under exampleSite/
// -- including the demo posts -- is present in the tarball that consuming sites
// download. See ../README.md.
module github.com/robertozoia/hugo-theme-ristretto/exampleSite

go 1.25

require github.com/robertozoia/hugo-theme-ristretto v0.0.0

// Build the demo against the working tree, not a published version.
replace github.com/robertozoia/hugo-theme-ristretto => ../
