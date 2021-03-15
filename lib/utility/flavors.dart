enum Flavor { dev, prod }

Flavor appFlavor = Flavor.dev;

void setAppFlavor(Flavor flavor) {
  appFlavor = flavor;
}

Flavor getAppFlavor() => appFlavor;

String getStorageValuesKey() {
  return appFlavor == Flavor.dev ? 'values' : 'values_dev';
}