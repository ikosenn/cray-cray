"""
    Author: ikosenn

    This is a program to eliminate stale git branches.
    It checks last commits and based on the staleness threshold
    eliminates all stale branches

    Another CL function is provided to eliminate all available branches.

    You can also remove all branches that have already been merged to
    the main branch
"""
import os

from datetime import datetime

import click
from sarge import capture_stdout

import pytz

from dateutil.parser import parse


DEFAULT_BRANCH = 'master'


# helper functions
def get_time_difference(time):
    """
    Computes the difference with todays time
    """
    timezone = "Africa/Nairobi"
    branch_time = parse(time)
    current_time = datetime.now(pytz.timezone(timezone))
    diff_days = (current_time - branch_time)
    return diff_days.days


def cwd(path):
    os.chdir(path)


@click.command()
@click.option(
    '--threshold', '-t',
    default=10,
    prompt='What number of days should the threshold be? [10 days]')
@click.option(
    'branches', '--branch', '-b', default=DEFAULT_BRANCH,
    prompt='What branches should be excluded? [master]', multiple=True)
@click.option(
    '--path', '-p', prompt='File path to the git repo?',
    type=click.Path(exists=True))
def fummy(threshold, branches, path):
    cwd(path)

    all_branches = capture_stdout('git branch')
    # remove spaces and any blank spaces
    temp = all_branches.stdout.text.replace(
        '*', '').replace(' ', '').split('\n')
    for branch in temp:
        if branch and branch not in branches:
            click.echo('Processing branch: {}'.format(branch))
            p = capture_stdout(
                'git show {} --format="%cI" --no-patch'.format(branch))
            diff_days = get_time_difference(p.stdout.text)
            if diff_days > threshold:
                click.echo('Deleting {}'.format(branch))
                p = capture_stdout(
                    'git branch -D {}'.format(branch))
                click.echo(p.stdout.text)


@click.command()
@click.option('--filename', type=click.Path(exists=True))
@click.option('--default', '-d', default=DEFAULT_BRANCH)
def kill_merged(default):
    """
        Start by checking out to the master branch and then finding out the
        branches already merged to master and eliminating the buggage
    """

    # git branch --merged master
    pass


@click.group()
def cli():
    """
    Command Line Interface tools loader for  ``fummy``
    These utilities help with deleting git branches older than the specified
    period
    """
    pass


cli.add_command(fummy)

if __name__ == '__main__':
    cli()
