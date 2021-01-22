name='seexpr'
version = '2.11.0'
requires = []

def commands():
    env.SEEXPR_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/wdas/SeExpr.git', 'branch': 'v2.11'}
