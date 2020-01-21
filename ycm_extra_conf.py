import os
import subprocess
import ycm_core

def get_mpi_include_flags(mpicc='mpicc'):
    """ Attempt to use -show argument of MPI compiler wrapper to extract include flags """
    include_flags = []
    try:

        # Python 3, but YCM wants system Python which is old..
        #output = subprocess.run([mpicc,'-show'],capture_output=True)
        #flags = output.stdout.split()
        output = subprocess.check_output([mpicc,'-show'])
        flags = output.split()
        for flag in flags:
            if flag.startswith(b'-I'):
                include_flags.append(flag.decode('utf-8'))
    #except FileNotFoundError:
    except OSError:
        pass
    return include_flags

flags = [
'-Wall',
'-Wextra',
'-I','/opt/local/include',
'-std=c99',                # Change if not using C
'-x','c',                  # Change if not using C
]

# MPI
flags.extend(get_mpi_include_flags())

# PETSc
PETSC_DIR=os.getenv('PETSC_DIR')
PETSC_ARCH=os.getenv('PETSC_ARCH')
if PETSC_DIR :
    flags.extend(['-I',PETSC_DIR+'/include',])
if PETSC_ARCH and PETSC_DIR :
    flags.extend(['-I',PETSC_DIR+'/'+PETSC_ARCH+'/include',])

# pTatin3D
PTATIN_DIR=os.getenv('PTATIN_DIR')
if PTATIN_DIR :
    flags.extend([
    '-I',PTATIN_DIR+'/include',
    '-I',PTATIN_DIR+'/src',
    ])

# StagBL
STAGBL_DIR=os.getenv('STAGBL_DIR')
if STAGBL_DIR :
    flags.extend([
    '-I',STAGBL_DIR+'/include',
    '-I',STAGBL_DIR+'/include/stagbl/private',
    ])

# LaMEM
LAMEM_DIR=os.getenv('LAMEM_DIR')
if LAMEM_DIR :
    flags.extend([
    '-I',LAMEM_DIR+'/src',
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

