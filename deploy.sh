## build static website for book
mdbook build

## init git repo
cd book
mkdir assets
cp ../assets/** assets/
git init
git config user.name "photino"
git config user.email "panzan89@163.com"
git add .
git commit -m 'deploy'
git branch -M gh-pages
git remote add origin https://github.com/zino-rs/zino-docs-zh

## push to github pages
git push -u -f origin gh-pages