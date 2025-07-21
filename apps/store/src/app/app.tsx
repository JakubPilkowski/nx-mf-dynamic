import * as React from 'react';
import NxWelcome from './nx-welcome';
import { Link, Route, Routes } from 'react-router-dom';
import { loadRemote } from '@module-federation/enhanced/runtime';
// import { hello } from 'lib/hello';

const Product = React.lazy(() => loadRemote('product/Module') as any);
const Checkout = React.lazy(() => loadRemote('checkout/Module') as any);

export function App() {
  const [helloMsg, setHelloMsg] = React.useState('');

  React.useEffect(() => {
    loadRemote('lib/lib').then((module) => {
      console.log('🚀 ~ loadRemote ~ module:', module);
      setHelloMsg(module.hello());
    });
  }, []);

  return (
    <React.Suspense fallback={null}>
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/product">Product</Link>
        </li>
        <li>
          <Link to="/checkout">Checkout</Link>
        </li>
      </ul>
      <Routes>
        <Route path="/" element={<NxWelcome title={helloMsg} />} />
        <Route path="/product" element={<Product />} />
        <Route path="/checkout" element={<Checkout />} />
      </Routes>
    </React.Suspense>
  );
}

export default App;
