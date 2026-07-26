# 複素数まわりの定義を、structured-latex の定義式どおりに素朴に組み上げたもの。
# numpy/Sage の組み込み（abs, angle, sqrt）とは独立な経路になるようにしてある。
# 対応: <definition_of_cc> <angle_equivalence_class> <angle_section_existence_uniqueness>
#       <section_of_angle_representation> <polar_equivalence_class> <def_phi_polar>
#       <def_phi_cartesian> <first_and_second_projections> <def_abs_arg> <def_sqrt_cc>
import math

def sqrt_nonneg(x):
    """<definition_of_sqrt_r_positive>: 非負実数の平方根を二分法で構成する（組み込みを使わない）。"""
    x = float(x)
    assert x >= 0
    if x == 0.0:
        return 0.0
    lo, hi = (0.0, 1.0) if x <= 1.0 else (0.0, x)
    for _ in range(200):
        mid = (lo + hi)/2
        if mid*mid <= x:
            lo = mid
        else:
            hi = mid
    return (lo + hi)/2

def n_of_theta(theta):
    """<angle_section_existence_uniqueness>: 0 <= theta - 2 n pi < 2 pi なる n。"""
    return int(math.floor(theta/(2*math.pi)))

def s_02pi(theta):
    """<section_of_angle_representation>: 角度表現の切断。"""
    return theta - 2*n_of_theta(theta)*math.pi

def phi_polar(z):
    """<def_phi_polar>: C -> 極座標表現。代表元 (r, theta) を返す。"""
    x, y = float(z.real), float(z.imag)
    r = sqrt_nonneg(x*x + y*y)
    if x > 0:
        return (r, math.atan(y/x))
    if x < 0 and y >= 0:
        return (r, math.atan(y/x) + math.pi)
    if x < 0 and y < 0:
        return (r, math.atan(y/x) - math.pi)
    if x == 0 and y > 0:
        return (y, math.pi/2)
    if x == 0 and y < 0:
        return (-y, -math.pi/2)
    return (0.0, 0.0)

def phi_cartesian(r, theta):
    """<def_phi_cartesian>: 極座標表現 -> C。"""
    return complex(r*math.cos(theta), r*math.sin(theta))

def pr1(z):
    return phi_polar(z)[0]

def pr2_theta(z):
    """<first_and_second_projections>: r = 0 のとき [0]、それ以外は [theta]。代表元を返す。"""
    r, th = phi_polar(z)
    return 0.0 if r == 0.0 else th

def abs_def(z):
    """<def_abs_arg>: |z| := pr_1(phi_polar(z))。"""
    return pr1(z)

def arg_def(z):
    """<def_abs_arg>: arg^{[0,2pi)}(z) := s_{[0,2pi)}(pr_2(phi_polar(z)))。"""
    return s_02pi(pr2_theta(z))

def sqrt_def(z):
    """<def_sqrt_cc>: 定義式そのまま（pr_1, pr_2, s_{[0,2pi)} 経由）。"""
    return phi_cartesian(sqrt_nonneg(pr1(z)), 0.5*s_02pi(pr2_theta(z)))

# テスト用の複素数（0、実軸上、虚軸上、各象限、境界近傍を含む）
def sample_complex(rng, extra=()):
    base = [complex(0,0), complex(1,0), complex(-1,0), complex(0,1), complex(0,-1),
            complex(3,4), complex(-3,4), complex(-3,-4), complex(3,-4),
            complex(1e-9,1e-9), complex(1e6,-1e6), complex(2,0), complex(-5,0),
            complex(0.5,1e-15), complex(-0.5,-1e-15)]
    rs = [complex(rng.normal(), rng.normal()) for _ in range(40)]
    # 単位円上（偏角を細かく振る）
    circ = [complex(math.cos(t), math.sin(t)) for t in [k*math.pi/12 for k in range(24)]]
    return base + rs + circ + list(extra)
