import os
import ycm_core

flags = [
'-Wall',
'-Wextra',
'-I','/opt/local/include', 
'-std=c99',                # Change if not using C
'-x','c',                  # Change if not using C
]

PETSC_ARCH=os.getenv('PETSC_ARCH',None)
PETSC_DIR=os.getenv('PETSC_DIR',None)
if PETSC_ARCH and PETSC_DIR :
    flags.extend([
    '-I',PETSC_DIR+'/include',
    '-I',PETSC_DIR+'/'+PETSC_ARCH+'/include',
    ])

PTATIN_DIR=os.getenv('PTATIN_DIR',None)
if PTATIN_DIR :
    flags.extend([
    '-I',PTATIN_DIR+'/include',
    '-I',PTATIN_DIR+'/src',
    ])

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )

def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags

def FlagsForFile( filename, **kwargs ):
  relative_to = DirectoryOfThisScript()
  final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }