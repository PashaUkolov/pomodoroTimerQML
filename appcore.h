#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = nullptr);

public:
    Q_INVOKABLE void debugPrint();
signals:
};

#endif // APPCORE_H
