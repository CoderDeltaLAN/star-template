from star_template import ping


def test_ping():
    assert ping() == "pong"
