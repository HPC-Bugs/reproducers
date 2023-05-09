# HPC Bug Reproducers

This repository serves as a publicly visibile place to submit information necessary for reproducing bugs encountered at HPC centers.
The intent is that in concert with submitting a bug report to a vendor or open source project the information is also submitted here so that other HPC centers can confirm the bug, and point users to the information.

## Organization

At early stages of the project we are still flexible with the organization,
but the goal is to keep it reasonably straightforward to find relevant information.
The convention is to put the information for the problem you are reporting in a folder with a path like `tool-kind/project-name/brief-description/`.
I.e. `compiler/Fortran/gfortran/polymorphic-associate/`.

## Report Contents

When creating a report/reproducer, at minimum a README.md file should be included in the folder.
The README should contain the following information:

* The version(s) of the tool and the environment(s) in which it malfunctions
* Point to additional content in the folder necessary to reproduce the issue
* Detailed description of the steps needed to reproduce the issue
* (optional) A description for how to work around the issue

Any other source code, input files, etc. should also be included in the created folder sufficient for an independent contributor to reproduce the encountered issue.

## Contributing

The procedure for contributing content to this report is as follows:

1. Confirm that you have permission to publish any content needed to reproduce the issue you are reporting.
   A. For example, if reporting a compiler bug, confirm permission to publish the source code which elicited the bug.
2. Create a pull request with content as described [above](#Report-Contents).
3. Request a review from someone who can confirm the issue.
   For example someone else at your center that can confirm the steps to reproduce are correct and sufficient,
   or someone at another center who can confirm that the issue exists also in their environment.
5. Once the PR is merged, open a bug report with the relevant project/vendor, pointing them to the submitted folder.
6. Track the issue and open PR's to update content as appropriate. I.e. adding versions and environments affected, workarounds, etc.
7. When a fix has been published and sufficiently diseminated, open a PR to remove the repport
   A. This will help to keep the repository from getting cluttered/dominated by old issues
   B. The PR description should identify the version of the tool containing the fix and a pointer to some indication from the developer of that tool announcing the fix.

## PR Review Procedure

For anyone who has been requested to review a PR to this repository, please use the following guidelines for performing the review.

### Reporting a New Issue

1. Verify that the PR reports a single issue.
2. Verify that the content is within a new, single folder with an appropriate path.
3. Ensure the README contains the information as specificed [above](#Report-Contents).
4. Confirm that you can follow directions provided to reproduce the issue

### Removing a Resolved Issue

1. Confirm that the PR deletes all of and only the contents related to a single issue
2. Verify that information identifying the fixed version has been provided in the PR description
3. Confirm that the identified version does in fact resolve the issue
