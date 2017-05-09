# craft 3 composer installation problem demonstration

to reproduce:

```
docker build -t temp .
docker run temp composer install --dry-run
```

result as of 2017-05-09:

```
<...docker build output...>

Loading composer repositories with package information
Updating dependencies (including require-dev)
Your requirements could not be resolved to an installable set of packages.

  Problem 1
    - Installation request for craftcms/cms 3.0.0-beta.14 -> satisfiable by craftcms/cms[3.0.0-beta.14].
    - craftcms/cms 3.0.0-beta.14 requires bower-asset/d3 ~4.8.0 -> no matching package found.

Potential causes:
 - A typo in the package name
 - The package is not available in a stable-enough version according to your minimum-stability setting
   see <https://getcomposer.org/doc/04-schema.md#minimum-stability> for more details.

Read <https://getcomposer.org/doc/articles/troubleshooting.md> for further common problems.
```
