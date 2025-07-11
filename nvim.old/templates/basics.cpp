#include <bits/stdc++.h>
using namespace std;

// Custom output stream operators (optional)
template <typename A, typename B>
ostream &operator<<(ostream &os, const pair<A, B> &p) {
    return os << '(' << p.first << ", " << p.second << ')';
}
template <typename T_container, typename T = typename enable_if<
                                    !is_same<T_container, string>::value,
                                    typename T_container::value_type>::type>
ostream &operator<<(ostream &os, const T_container &v) {
    os << '{';
    string sep;
    for (const T &x : v)
        os << sep << x, sep = ", ";
    return os << '}';
}
void dbg_out() { cerr << endl; }
template <typename Head, typename... Tail> void dbg_out(Head H, Tail... T) {
    cerr << ' ' << H;
    dbg_out(T...);
}
#ifdef LOCAL
#define dbg(...) cerr << "(" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)
#else
#define dbg(...)
#endif

#define ar array
#define ll long long
#define ld long double
#define sza(x) ((int)x.size())
#define all(a) (a).begin(), (a).end()

// Constants
const int MAX_N = 1e5 + 5;
const ll MOD = 1e9 + 7;
const ll INF = 1e9;
const ld EPS = 1e-9;

void solve() {
    // Your solution logic here

    cout << endl;
}

int main() {
#ifndef ONLINE_JUDGE
    freopen("/home/akileshas/repos/algoX/input.txt", "r", stdin);
    freopen("/home/akileshas/repos/algoX/output.txt", "w", stdout);
#endif

    ios_base::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);

    int tc = 1; // Number of test cases
    // Uncomment the next line if the number of test cases is provided as input
    // cin >> tc;

    for (int t = 1; t <= tc; t++) {
        // Uncomment the following line if the case number should be output
        // cout << "Case #" << t << ": ";
        solve();
    }

    return 0;
}
