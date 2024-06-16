def is-git-repo [] {
  let result = git rev-parse --is-inside-work-tree | complete
  $result.exit_code == 0
}

def git-path [repo: string] -> string {
    let repo_basename = $repo | path basename
    let subpath = $env.PWD | path relative-to $repo

    # avoids showing a trailing slash when we're at the root of the repo
    if ($subpath | str length) > 0 {
      $repo_basename | path join $subpath
    } else {
      $repo_basename
    }
}

export def left-prompt [] {
  mut sections = []
  let in_repo = is-git-repo

  let path = if $in_repo {
    let repo = git rev-parse --show-toplevel | str trim
    git-path $repo
  } else {
    $env.PWD
  }
  $sections ++= $path

  ($sections | str join ' ') + ' '
}

export def right-prompt [] {
  let s = shells
  let nshells = $s | length
  if $nshells > 1 {
    let active = ($s | enumerate | where item.active | first | get index) + 1
    $"\(($active)/($nshells)\)"
  }
}